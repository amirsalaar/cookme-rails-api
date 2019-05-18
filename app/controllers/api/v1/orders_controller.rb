class Api::V1::OrdersController < Api::ApplicationController
    before_action :authenticate_user!
    
    def index
			render json: {orders: current_user.orders}
    end
    
    def show
			order = current_user.orders.find(params[:id])
			render json: order
    end
    
		def create
			order = Order.new
			order.user = current_user
			order.save!
			order.place(current_order)
			order.reload.set_total!
			order.save!        
			render json: {status: 200, order: order}, status: 200
    end
    
    private
    # def order_params
    #     params.require(:order).permit(
    #             order_details: [
    #                     :food_id,
    #                     :order_quantity
    #             ]
    #     )
    # end   

    def authorize_user!
			render json: { status: 401 }, status: 401 unless can?(:place, order)
    end
end
