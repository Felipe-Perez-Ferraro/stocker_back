class Users::SessionsController < Devise::SessionsController
  include RackSessionFix
  respond_to :json

  def create
    user = User.find_by(name: params[:user][:name])

    if user.present? && user.valid_password?(params[:user][:password])
      sign_in(user) # This will set up the session for the user
      token = JWT.encode({ sub: user.id, jti: user.jti },
                         Rails.application.credentials.devise_jwt_secret_key!)

      render json: {
        status: {
          code: 200, message: 'Logged in successfully.',
          data: { user: UserSerializer.new(user).serializable_hash[:data][:attributes].merge(token: token) }
        }
      }, status: :ok
    else
      render json: {
        status: { message: "Invalid username or password." }
      }, status: :unprocessable_entity
    end
  end
end
