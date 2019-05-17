class Api::V1::OrdersController < Api::ApplicationController
    before_action :authenticate_user!
    
    def index
        render json: {orders: current_user.orders}
    end
    
    def show
        order = current_user.orders.find(params[:id])
        render json: {id: order.id)}
    end
    
    def create
        order = Order.new order_params
        order.user = current_user
        order.save!
        render json: {status: 200, id: order.id}, status: 200
    end
    
    private
    def order_params
        params.require(:order).permit(food_ids: [])
    end   

    def authorize_user!
        render json: { status: 401 }, status: 401 unless can?(:place, order)
    end
end
