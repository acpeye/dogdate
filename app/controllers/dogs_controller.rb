class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :edit, :new, :create, :preview, :update]
  before_action :set_dog, only: [:show, :edit, :update, :delete]

  def index
    # @dogs = Dog.all
    @dogs = policy_scope(Dog)
    skip_authorization
  end

  def show
    @dog = Dog.find(params[:id])
    @playdate = Playdate.new
    skip_authorization
  end

  def new
    @owner = Owner.find(params[:owner_id])
    @dog = Dog.new
    skip_authorization
  end

  def preview
    @owner = Owner.find(params[:owner_id])
    @dog = Dog.new(dog_params)
    @dog.owner = @owner
    images = []
    images << dog_params[:images_url]
    @dog.images_url = images
    render :new
    skip_authorization
  end

  def create
    @owner = Owner.find(params[:owner_id])
    @dog = Dog.new(dog_params)
    @dog.owner = @owner
    @dog.images_url << dog_params[:image]
    @dog.available_dates << make_date_time
    authorize(@dog)
    if @dog.save
      redirect_to dog_path(@dog)
    else
      render :new
    end
  end

  def edit
    skip_authorization
  end

  def update
    @dog.images_url.unshift(dog_params[:image]) unless @dog.image == dog_params[:image]
    @dog.available_dates << make_date_time unless dog_params["time(1i)"].nil?
    authorize(@dog)
    if @dog.update(dog_params)
      redirect_to dog_path(@dog)
    else
      render :edit
    end
  end

  def destroy
    authorize(@dog)
    @dog.destroy
  end

  private

  def make_date_time
    "#{dog_params["time(1i)"]}/#{dog_params["time(2i)"]}/#{dog_params["time(3i)"]} at #{dog_params["time(4i)"]}:#{dog_params["time(3i)"]}"
  end

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(:name, :description, :breed, :image, :time, :date, :hourly_price)
  end
end
