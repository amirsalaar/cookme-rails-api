class Api::V1::SchedulesController < Api::ApplicationController
  before_action :find_food, only: [:create, :destroy]
  
  def create
    @food.schedules&.clear

    (schedule_params&.map {|sc| Schedule.new(weekday: sc[:weekday], quantity: sc[:quantity], food: @food)}).map {|s| s.save! }

    render json: { status: 200, schedules: @food.schedules }, status: 200
  end

  def destroy
    @food.schedules.destroy
    render json: { status: 200 }, status: 200
  end

  private
  def find_food
    @food = Food.find(params[:food_id])
  end
  
  def schedule_params
    params.require(:schedules)
  end
end
