class Api::V1::FoodsController < Api::ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :find_food, only: [:show]

    def show
        render json: @food
    end

    def create
        food = Food.new food_params
        food.cook = current_user
        food.save!
        schedules_arr = schedule_params[:schedules]
        (schedules_arr.map {|sc| Schedule.new(weekday: sc[:weekday], quantity: sc[:quantity], food: food)}).map {|s| s.save! }

        render json: { id: food.id }, status: 200
    end

    def destroy
        food.destroy
        render json: { status: 201 }, status: 201
    end

    private
    def find_food
        @food = Food.find(params[:id])
    end

    def food_params
        params.require(:food).permit(:name, :description, :price)
    end

    def schedule_params
        params.require(:schedules).permit({
            schedules: [
                [
                    :weekday,
                    :quantity
                ]
            ]
        })
    end
    
end
