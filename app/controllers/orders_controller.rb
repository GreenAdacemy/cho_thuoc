class OrdersController < ApplicationController
  before_action: authenticate_user!, :fetch_user

  def index
  end

  def fetch_user
    @current_user = current_user
  end

  def shipping_info
    @shipping_info = current_user.shipping_infos.new 
  end

  def show
    @cart =Order.find_by(id: params[:id])
  end

  def checkout
    @cart = Order.find_by(id: params[:id])
  end

end
