class Api::V1::FoodsController < Api::ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]

    def create
        binding.pry
        food = Food.new food_params
        food.schedules << Schedule.new(schedule_params)
        food.cook = current_user
        food.save!
        render json: { food: food }, status: 200
    end


    private
    def food_params
        params.require(:food).permit(:name, :description, :price)
    end

    def schedule_params
        params.require(:schedule).permit(:weekday, :quantity)
    end
    
    
end
