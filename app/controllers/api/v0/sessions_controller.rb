module Api
  module V0
    class SessionsController < ApplicationController

      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          render json: UsersSerializer.new(user), status: :ok
        else
          render json: { errors: ['Invalid email or password'] }, status: :unauthorized
        end
      end
    end 
  end
end