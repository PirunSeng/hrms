module Api
  module V1
    module Profile
      class UsersController < Api::V1::BaseApiController
        before_action :find_user, only: [:show, :update, :destroy]

        def index
          users = User.all
          json_response(users)
        end

        def show
          json_response(@user)
        end

        def create
          user = User.create!(user_params)
          json_response(user, :created)
        end

        def update
          @user.update!(user_params)
          json_response(@user)
        end

        def destroy
          @user.destroy
          head :no_content
        end

        private

        def user_params
          params.permit(:name, :email, :phone, :address, :salary, :start_date, :performance, :position_id, :department_id)
        end

        def find_user
          @user = User.find(params[:id])
        end
      end
    end
  end
end
