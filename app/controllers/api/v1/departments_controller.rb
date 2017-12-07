module Api
  module V1
    class DepartmentsController < Api::V1::BaseApiController
      def index
        @departments = Department.all
        json_response(@departments)
      end
    end
  end
end
