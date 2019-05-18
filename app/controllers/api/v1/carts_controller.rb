class Api::V1::CartsController < Api::ApplicationController
    def show
        render json: current_order
    end
end
