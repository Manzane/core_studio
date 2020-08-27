class LessonsController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :set_lesson, only: [:show]
    def index
        @lessons = Lesson.all
        @booking = Booking.new
        if current_user
            if current_user.credits
                @credits = current_user.credits
            end
        end
        # @calendar_events = @lessons.flat_map{ |e| e.calendar_events(params.fetch(:start_date, Time.zone.now).to_date) }
    end

    def show
        # raise
    end

    private

    def set_lesson
      @lesson = Lesson.find(params[:id])
    end
  
end
