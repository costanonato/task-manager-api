class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    begin
      @user = User.find(params[:id])
      respond_with @user
    rescue
      head 404
    end
  end
end
