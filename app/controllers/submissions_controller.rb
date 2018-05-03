class SubmissionsController < ApplicationController
  before_action :set_user
  before_action :set_user_submission, only: [:show, :update, :destroy]

  def index
    json_response(@user.submissions)
  end

  def show
    json_response(@submission)
  end

  def create
    @submission = @user.submissions.create!(submission_params)
    json_response(@submission, :created)
  end

  def update
    @submission.update(submission_params)
    head :no_content
  end

  def destroy
    @submission.destroy
    head :no_content
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_submission
    @submission = @user.submissions.find_by!(id: params[:id]) if @user
  end

  def submission_params
    params.permit(:title, :link, :body)
  end
end
