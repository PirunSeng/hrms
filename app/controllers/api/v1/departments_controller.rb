module Api
  module V1
    class DepartmentsController < Api::V1::BaseApiController
      before_action :find_department, only: [:show, :update, :destroy]
      def index
        @departments = Department.all
        json_response(@departments)
      end

      def show
        json_response(@department)
      end

      def create
        department = Department.create!(department_params)
        json_response(department, :created)
      end

      def update
        @department.update!(department_params)
        json_response(@department)
      end

      def destroy
        @department.destroy
        head :no_content
      end

      private

      def department_params
        params.permit(:name, :description)
      end

      def find_department
        @department = Department.find(params[:id])
      end
    end
  end
end
