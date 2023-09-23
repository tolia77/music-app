class UsersController < ApplicationController
  def show
    @user = User.find_by(params[:user_id])
    p user_signed_in?
    if user_signed_in? && current_user == @user
      render json: @user
    else
      render json: @user.to_json(only: %i[id name created_at])
    end
  end
end
