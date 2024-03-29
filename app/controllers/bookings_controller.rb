class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_lesson, only: [:new, :create]
  def index
    @bookings = current_user.bookings.all
  end

  def show
  end

  # def new
  #   @booking = Booking.new
  #   credits = current_user.credits.find_by(category_id: @lesson.category_id)
  #   if credits
  #     @credits = credits.quantity
  #   else
  #     flash.now[:alert] = "Il vous faut des crédits pour réserver une séance"
  #     redirect_to packages_path
  #   end
  #   # raise
  # end

  def create
    @booking = Booking.new(booking_params)
    @booking.lesson_id = @lesson.id
    @booking.user_id = current_user.id
    @booking.quantity = 1
    credits_updater = CreditsUpdater.new(booking_params, current_user, {lesson: @lesson})
    if credits_updater.check_credits
      @booking.transaction do
        if @booking.save!
          if credits_updater.decrease
            redirect_to bookings_path, notice: "Réservation effectuée"
          # lesson_booking_path(lesson_id, @booking), notice: "Réservation effectuées"
          else
            flash.now[:alert] = "Réservation non effectuée, dûe à un problème technique, contactez l'administrateur du site !"
            # render :new
          end 
        else
          @booking.errors.full_messages
            # render :new
        end
      end
    else
      flash.now[:alert] = "Vous avez demandé une quantité supérieure au nombre de vos crédits"
      # render :new
    end
  end

  def destroy
    @lesson = @booking.lesson
    @lesson.transaction do
      if @lesson.one_day_before_lesson?
        credits_updater = CreditsUpdater.new(@booking, current_user, {lesson: @lesson})
        credits_updater.increase
      end
      @booking.destroy
    end
    redirect_to bookings_path, notice: "Réservation annulée et compte recrédité !"
  end


  private

  def set_booking
    @booking = current_user.bookings.find(params[:id])
  end

  def set_lesson
    # @lesson = Lesson.find(params[:lesson_id])
    @lesson = Lesson.find(params[:booking][:lesson_id])
  end

  def booking_params
    params.require(:booking).permit(:quantity)
  end

end