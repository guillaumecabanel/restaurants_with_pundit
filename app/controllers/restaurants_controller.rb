class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show
    authorize @restaurant
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def edit
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant

    if @restaurant.save
      redirect_to @restaurant
    else
      render :new
    end
  end

  def update
    authorize @restaurant
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant
    else
      render :edit
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    authorize @restaurant
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
