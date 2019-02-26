class ProfilesController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @current_user = current_user
    @dogs = current_user.dogs if current_user.class == Owner
  end

  def edit
    @current_user = current_user
  end

  def update
    @current_user = current_user
    @current_user.update(current_user_params)
  end

  private

  def current_user_params
    params.require(:current_user).permit(:avatar_url, :first_name, :last_name, :description, :location, :password)
  end
end
