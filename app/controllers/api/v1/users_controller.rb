class Api::V1::UsersController < Api::ApplicationController
    before_action :authenticate_user!, only: [:update, :update_password]
    before_action :find_user, only: [:update, :update_password]
    before_action :authorize_user!, only: [:update]
    
    def current
        render json: current_user
    end
    
    def create    
        user = User.new user_params
        user.save!
        session[:user_id] = user.id
        session[:current_order] = []
        render json: {id: user.id}
    end

    def update
        @user&.update! user_params
        render json: {status: 200}, status: 200
    end
    
    def update_password
        if @user&.authenticate(params[:current_password])
            if params[:new_password] == params[:current_password]
                @user.errors.add(:current_password, "New password cannot be tyhe same as old password!")
                render json: {errors: @user.errors.messages}, status: 422
            else
                check_and_update_password
            end
        else
            @user.errors.add(:current_password, "Your current password is invalid")
            render json: {errors: @user.errors.messages}, status: 422
        end      
    end
    
    private
    def user_params
        # params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :phone_number, :role, :avatar, address: [:street_address, :city, :province, :postal_code])
        {
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation],
            phone_number: params[:phone_number],
            address: params[:address],
            role: params[:role].to_i,
            avatar: params[:avatar],
            certificate: params[:certificate]
        }

    end

    def find_user
        @user = User.find_by(id: current_user.id)
    end

    def check_and_update_password
        if params[:new_password] == params[:new_password_confirmation]
            @user.update!(password: params[:new_password])
            render json: {status: 200}, status: 200
        else
            @user.errors.add(:new_password, "Password confirmation does not match new password!")
            render json: {errors: @user.errors.messages}, status: 422
        end      
    end

    def authorize_user!
        unless can?(:crud, @user)
            render json: { status: 401 }, status: 401
        end
    end
    
end
