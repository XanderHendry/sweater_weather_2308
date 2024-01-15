module Api
  module V0
    class ForecastsController < ApplicationController

      def by_city
        location = LocationFacade.get_location_data(params[:location])
        render json: ForecastSerializer.new(location).serialize_json, status: 200 
      end

      private

      def query_params
        params.permit(:location)
      end
    end 
  end
end