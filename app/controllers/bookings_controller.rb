class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @flat
    @booking.price = @flat.price
    @booking.status = "pending"
    if @booking.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @flat = flat.find(@booking.flat_id)
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.status = "accepted"
    @booking.save
    redirect_to dashboard_path
  end

  def decline
    @booking = Booking.find(params[:id])
    @booking.status = "declined"
    @booking.save
    redirect_to dashboard_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :flat_id, :status)
  end
end
