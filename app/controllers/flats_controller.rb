class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]

  def index
    @flatss = Flat.all

  end

  def show
    @booking = Booking.new
    # @flats = flat.geocoded #returns flats with coordinates

    # @markers = @flats.map do |flat|
    #   {
    #     lat: flat.latitude,
    #     lng: flat.longitude,
    #     infoWindow: render_to_string(partial: "info_window", locals: { flat: flat })
    #   }
    # end
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @flat.update(flat_params)
    redirect_to flats_path
  end

  def destroy
    @flat.destroy
    redirect_to flats_path
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :description, :adress, :photo, :price)
  end

  def set_flat
    @flat = flat.find(params[:id])
  end
end
