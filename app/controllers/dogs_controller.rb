class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_dog, only: [:show, :edit, :update, :delete]

  def index
    # @dogs = Dog.all
    @dogs = policy_scope(Dog)
    skip_authorization
  end

  def show
    @dog = Dog.find(params[:id])
    skip_authorization
  end

  def new
    @owner = Owner.find(params[:owner_id])
    @dog = Dog.new
  end

  def create
    @owner = Owner.find(params[:owner_id])
    @dog = Dog.new(dog_params)
    @dog.owner = @owner
    authorize(@dog)
    if @dog.save
      redirect_to dog_path(@dog)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @dog.update(dog_params)
      redirect_to dog_path(@dog)
    else
      render :edit
    end
  end

  def destroy
    @dog.destroy
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(:name, :description, :breed, :image_url, :available_dates)
  end
end
