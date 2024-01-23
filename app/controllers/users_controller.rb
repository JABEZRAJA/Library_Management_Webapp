# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def show
    @user = current_user
    render json: { error: 'User not found' }, status: 404 unless @user&.id == params[:id].to_i
  end

  #   def index
  #     @all_users = User.all
  #   end

  # def edit
  #   @user = User.find_by(id: params[:id])
  # end
end
