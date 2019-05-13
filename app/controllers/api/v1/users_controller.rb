class Api::V1::UsersController < Api::ApplicationController
    def create
        user = User.new user_params
        byebug
        if user.save
            render json: {status: 201},status: 201
        else
            render json: {status: 400},status: 400
        end
    end

    def update
        
    end
    
    def destroy
        
    end

    def update_password
        
    end
    
    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :phone_number, :role, address: [:street_address, :city, :province, :postal_code])
    end
    
end
