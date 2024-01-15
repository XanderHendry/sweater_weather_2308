module Api
  module V1
    class MunchiesController < ApplicationController

      def search
        facade = MunchiesFacade.new(params[:destination], params[:food])
        render json: facade.restaurant_rec_and_weather, status: 200 
      end

      private

      def query_params
        params.permit(:destination, :food)
      end
    end 
  end
end