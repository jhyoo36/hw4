class PlacesController < ApplicationController

  def index
    @user = User.find_by({ "id" => session["user_id"] })
    @places = Place.all
  end

  def show
    @user = User.find_by({ "id" => session["user_id"] })
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @user["id"]})
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

end
