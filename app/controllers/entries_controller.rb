class EntriesController < ApplicationController
  before_action :require_login

  def new
    @entry = Entry.new(place_id: params["place_id"])
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    @entry["user_id"] = current_user["id"]
    @entry.uploaded_image.attach(params["uploaded_image"]) if params["uploaded_image"].present?

    if @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      render "new", status: :unprocessable_entity
    end
  end

end
