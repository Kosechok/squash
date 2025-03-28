class Api::UsersController < ApplicationController
  before_action :authenticate_user!
  include ApiResponse
  def show

  end

  def index
    @users = User.all

    render_success(@users, hide_details: true)
    # render json: @users
  end

  def me
    @user = current_user
    # render json: @user
    render_success(@user)
  end
end
