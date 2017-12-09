module Api
  module V1
    class BaseApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Response
      include ExceptionHandler
      before_action :authenticate_user!
    end
  end
end
