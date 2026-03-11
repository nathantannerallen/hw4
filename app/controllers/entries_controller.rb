class EntriesController < ApplicationController
  before_action :require_login

  def new
    @place = current_user.places.find_by(id: params["place_id"])

    if @place == nil
      redirect_to "/places"
      return
    end

    @entry = Entry.new(place_id: @place.id)
  end

  def create
    @place = current_user.places.find_by(id: params["place_id"])

    if @place == nil
      redirect_to "/places"
      return
    end

    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = @place.id
    @entry["user_id"] = current_user["id"]
    @entry.uploaded_image.attach(params["uploaded_image"]) if params["uploaded_image"].present?

    if @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      render "new", status: :unprocessable_entity
    end
  end

end
