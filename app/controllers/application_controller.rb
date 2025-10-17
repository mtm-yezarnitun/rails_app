class ApplicationController < ActionController::Base

    helper_method :current_user

    private

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    
    def require_login
        unless current_user
            redirect_to login_path, alert: "Please log in first."
        end
    end

end
