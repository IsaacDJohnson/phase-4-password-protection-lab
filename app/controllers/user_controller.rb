class UserController < ApplicationController

    def create 
        user = User.create(user_params)
        session[:user_id] = user.id
        if user.valid?
            render json: user, status: :created
        else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user
        else 
            return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
        end    
    end
    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
