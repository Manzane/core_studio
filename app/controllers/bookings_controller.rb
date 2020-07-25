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
    credits = current_user.credits.find_by(category_id: @lesson.category_id)
    if credits
      @credits = credits.quantity
    else
      redirect_to packages_path, notice: "Il vous faut des crédits pour réserver une séance"
    end
    # raise
    
  end

  def create
    @booking = Booking.new(booking_params)
    @lesson = Lesson.find(params[:lesson_id])
    @booking.lesson_id = @lesson.id
    @booking.user_id = current_user.id
    credits_updater = CreditsUpdater.new(booking_params, current_user, @lesson)
    if credits_updater.check_credits
      if @booking.save
        if credits_updater.decrease
          redirect_to bookings_path, notice: "Réservation effectuée"
        # lesson_booking_path(lesson_id, @booking), notice: "Réservation effectuées"
        else
          flash.now[:alert] = "Réservation non effectuée, dûe à un problème technique, contactez l'administrateur du site"
          render :new
        end 
      else
        @booking.errors.full_messages
          render :new
      end
    else
      flash.now[:alert] = "Vous avez demandé une quantité supérieure au nombre de vos crédits"
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