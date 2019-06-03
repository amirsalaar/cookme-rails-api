class Api::V1::SessionsController < Api::ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            session[:current_order] = []
            render json: { id: user.id }
        else
            render  json: {status: 404}, status: 404
        end
    end

    def add_to_cart
        # {order_details: {food_id: params[:food_id],order_quantity: params[:order_quantity]}}
        session[:current_order] << (params[:order_details])
        render json: current_order
    end

    def destroy_cart
        session[:current_order] = []
        render json: current_order, status: 200
    end
    
    def destroy
        session[:user_id] = nil
        session[:order_details] = nil
        render json: {status: 200}, status: 200
    end
end
