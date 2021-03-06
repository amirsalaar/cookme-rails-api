class Api::ApplicationController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    rescue_from(ActiveRecord::RecordInvalid, with: :record_invalid)
    rescue_from(ActiveRecord::RecordNotFound, with: :record_not_found)
    
    private
    def current_order
        if session[:current_order]
            current_order = session[:current_order]
        end
    end
    helper_method :current_order

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by_id(session[:user_id])
        end
    end
    helper_method :current_user

    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    def authenticate_user!
        unless user_signed_in?
            render json: {status: 401}, status: 401
        end
    end

    def record_invalid(error)
        invalid_record = error.record
        errors = invalid_record.errors.map do |field, message|
            {
                type: error.class.to_s,
                record_type: invalid_record.class.to_s,
                field: field,
                message: message
            }
        end
        render(
            json: { status: 422, errors: errors},
            status: 422
        )
    end

    def record_not_found(exception)
        render json: { error: exception.message }, status: :not_found
    end
    
end
