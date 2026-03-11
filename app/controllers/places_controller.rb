class PlacesController < ApplicationController
  before_action :require_login

  def index
    @places = Place.where({ "user_id" => current_user["id"] })
  end

  def show
    @place = Place.find_by({ "id" => params["id"], "user_id" => current_user["id"] })

    if @place == nil
      redirect_to "/places"
      return
    end

    @entries = Entry.where({ "place_id" => @place["id"], "user_id" => current_user["id"] })
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place["user_id"] = current_user["id"]
    @place.save
    redirect_to "/places"
  end

end
