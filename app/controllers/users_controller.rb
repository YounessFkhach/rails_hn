class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: :index

  def index
    @users = User.all
    json_response(@users)
  end

  # def create
  #   @user = User.create!(user_params)
  #   json_response(@user, :created)
  # end

  # def show
  #   json_response(@user)
  # end

  # def update
  #   @user.update(user_params)
  #   head :no_content
  # end

  # def destroy
  #   @user.destroy
  #   head :no_content
  # end

  
  # private
  # def set_user
  #   @user = User.find(params[:id])
  # end
  # def user_params
  #   params.permit(:name)
  # end

end
