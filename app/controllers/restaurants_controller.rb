class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    @average = average(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(resto_params)
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end


  private

def resto_params
  params.require(:restaurant).permit(:name, :address, :phone_number, :category)
end

def average(id)
  restaurant = Restaurant.find(id)
  avg = 0
  size = restaurant.reviews.size
  sum = 0
  if size == 0
    avg = 0
  else
    restaurant.reviews.each do |review|
      sum += review.rating
    end
  avg = sum/size
  end
  avg
end
end
