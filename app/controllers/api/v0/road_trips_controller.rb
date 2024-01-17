module Api
  module V0
    class RoadTripsController < ApplicationController

      def create
        user = User.find_by(api_key: params[:api_key])
        if !user.nil?
          road_trip = RoadTripFacade.plan_roadtrip({origin: params[:origin], destination: params[:destination]})
          render json: RoadTripSerializer.new(road_trip).serialize_json, status: :ok
        else
          render json: { errors: ['Unauthorized API Key'] }, status: :unauthorized
        end
      end

      private

      def query_params
        params.permit(:origin, :destination, :api_key)
      end
    end 
  end
end