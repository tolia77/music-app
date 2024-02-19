class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    authorize(current_user)
    render json: User.all
  end

  def show
    @user = User.find(params[:id])
    if current_user == @user
      render json: @user
    else
      render json: @user.to_json(only: %i[id name created_at])
    end
  end
end
