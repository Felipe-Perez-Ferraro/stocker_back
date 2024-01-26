class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all

    render json: { status: 'success', data: products }, status: :ok
  rescue StandardError => e
    render json: { status: 'error', message: e.message }, status: :internal_server_error  
  end

  def create
    product = Product.new(products_params)
    if product.save
      render json: { status: 'success', data: product }, status: :created
    else
      render json: { status: 'error', message: product.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy!
    render json: { message: 'Product successfully destroyed' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Product not found' }, status: :not_found
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: "Failed to destroy product: #{e.message}" }, status: :unprocessable_entity
  end

  def update
    product = Product.find(params[:id])

    if product.update(products_params)
      render json: { status: 'success', data: product }, status: :ok
    else
      render json: { status: 'error', message: product.errors }, status: :unprocessable_entity
    end
  end

  private

  def products_params
    params.require(:product).permit(:sku, :name, :category, :label, :quantity, :price)
  end
end