class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  def index
    @bookings = current_user.bookings.all
  end

  def show
  end

  def new
    @booking = Booking.new
    @lesson = Lesson.find(params[:lesson_id])
    @credits = current_user.credits.find_by(category_id: @lesson.category_id).quantity
    # raise
    
  end

  def create
    @booking = Booking.new(booking_params)
    @lesson = Lesson.find(params[:lesson_id])
    @booking.lesson_id = @lesson.id
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to bookings_path, notice: "Réservation effectuée"
      # lesson_booking_path(lesson_id, @booking), notice: "Réservation effectuées"
    else
      @booking.errors.full_messages
        render :new
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: "Réservation annulée"
  end


  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:quantity)
  end

end