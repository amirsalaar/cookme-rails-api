class Api::V1::UsersController < Api::ApplicationController
    def create
        user = User.new user_params
        if user.save
            session[:user_id] = user.id
            render json: {id: user.id}
        else
            render(
                json: { errors: user.errors.messages }, status: 422
            )
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
