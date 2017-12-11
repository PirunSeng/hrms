module Api
  module V1
    class PositionsController < Api::V1::BaseApiController
      before_action :find_position, only: [:show, :update, :destroy]

      def index
        positions = Position.all
        json_response(positions)
      end

      def show
        json_response(@position)
      end

      def create
        position = Position.create!(position_params)
        json_response(position, :created)
      end

      def update
        @position.update!(position_params)
        json_response(@position)
      end

      def destroy
        @position.destroy
        head :no_content
      end

      private

      def position_params
        params.permit(:title, :description)
      end

      def find_position
        @position = Position.find(params[:id])
      end
    end
  end
end
