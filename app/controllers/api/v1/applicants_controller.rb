module Api
  module V1
    class ApplicantsController < Api::V1::BaseApiController
      before_action :find_applicant, only: [:show, :update, :destroy]

      def index
        applicants = Applicant.all
        json_response(applicants)
      end

      def show
        json_response(@applicant)
      end

      def create
        applicant = Applicant.create!(applicant_params)
        json_response(applicant, :created)
      end

      def update
        @applicant.update!(applicant_params)
        json_response(@applicant)
      end

      def destroy
        @applicant.destroy
        head :no_content
      end

      private

      def applicant_params
        params.permit(:name, :email, :phone, :interview_status, :interview_date, :interview_result, :invitation_status)
      end

      def find_applicant
        @applicant = Applicant.find(params[:id])
      end
    end
  end
end
