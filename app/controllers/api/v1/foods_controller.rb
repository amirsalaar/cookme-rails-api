class Api::V1::FoodsController < Api::ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :find_food, only: [:show, :update, :destroy]
    before_action :authorize_user!, only: [:destroy, :update]

    def show
        render json: @food
    end

    def index
        foods = Food.order(created_at: :desc)
        render(
            json: foods,
            each_serializer: FoodCollectionSerializer
        )
    end

    def create
        food = Food.new food_params
        if can?(:cook, food)
            food.cook = current_user
        end
        food.save!
        # set_schedule([eval(schedule_params[0])], food)
        # schedule_ids: food.schedule_ids
        render json: { id: food.id }, status: 200
    end

    def update
        @food.update! food_params
        # if schedule_params
        #     @food.schedules.clear
        #     if not schedule_params&.empty?
        #         set_schedule(schedule_params, @food)
        #         @food.reload
        #     end
        # end
        render json: { id: @food.id }, status: 200
    end

    def destroy
       @food.destroy
        render json: { status: 201 }, status: 201
    end

    private
    def find_food
        @food = Food.find(params[:id])
    end

    def food_params
        params.require(:food).permit(:name, :description, :price, pictures: [])
    end

    # def schedule_params
    #     # params.require(:schedules).permit({
    #     #     schedules: [
    #     #         [
    #     #             :weekday,
    #     #             :quantity
    #     #         ]
    #     #     ]
    #     # })
    #     params[:schedules]
    # end
    
    # def set_schedule(schedules, food)
    #     (schedules&.map {|sc| Schedule.new(weekday: sc[:weekday], quantity: sc[:quantity], food: food)}).map {|s| s.save! }
    # end

    def authorize_user!
        render json: {status: 401}, status: 401 unless can?(:crud, @food)
    end
end
