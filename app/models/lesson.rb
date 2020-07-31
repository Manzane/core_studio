class Lesson < ApplicationRecord
  serialize :recurring, Hash
  belongs_to :category
  belongs_to :thematic
  has_many :bookings, dependent: :destroy
  validates :name, :start_time, presence: true

  # scope :with_bookings, -> (bookingId) {where("self.bookings == ?"), bookingId}

  
  def full?
    sum = 0
    self.bookings.each do | booking |
      sum += booking.quantity
    end
    if sum < self.capacity
      return false
    else
      return true
    end
  end

  def available_quantity
    capacity = self.capacity
    booked = 0
    self.bookings.each do | booking |
      booked += booking.quantity
    end
    return capacity - booked
  end
  def one_day_before_lesson?
    if ((self.start_time -  DateTime.now).to_i / 86400) >= 1
      # raise
    return true
    else
      return false
    end  
  end
  def past_lesson?
    if ((self.start_time -  DateTime.now).to_i / 86400) < 1
      # raise
    return true
    else
      return false
    end  
  end
  
  # def recurring=(value)
  #   super
  # end

  # def rule
  #   IceCube::Rule.weekly
  #   # IceCube::Rule.weekly(2).day(:monday, :tuesday)

  # end

  def schedule(day)
    schedule = IceCube::Schedule.new
    case day      
      when 'monday'
        schedule.add_recurrence_rule IceCube::Rule.weekly(1).day(:monday)
      when 'tuesday'
        schedule.add_recurrence_rule IceCube::Rule.weekly(1).day(:tuesday)
      when 'wednesday'
        schedule.add_recurrence_rule IceCube::Rule.weekly(1).day(:wednesday)
      when 'thursday'
        schedule.add_recurrence_rule IceCube::Rule.weekly(1).day(:thursday)
      when 'friday'
        schedule.add_recurrence_rule IceCube::Rule.weekly(1).day(:friday)
      when 'saturday'
        schedule.add_recurrence_rule IceCube::Rule.weekly(1).day(:saturday)
      when 'sunday'
        schedule.add_recurrence_rule IceCube::Rule.weekly(1).day(:sunday)
      end
    # schedule.add_recurrence_rule rule
    # event_exceptions.each do |exception|
    #   schedule.add_exception_time(exception.time)
    # end
    schedule
  end


  def create_recurring_events(args = {})
  #   if recurring.empty?
  #     [self]
  #   else
    # start_date = Time.now
    schedule(args[:day]).occurrences_between(args[:start_time], args[:end_date]).each do |date|
      Lesson.create!(thematic: thematic, category: category, name: name, capacity: capacity, start_time: date.change({ hour: args[:hour], min: args[:minute], sec: 0 }), duration: duration)
    end
  end

  # def schedule(value, options={})
  #   schedule = IceCube::Schedule.new
  #   schedule.add_recurrence_rule IceCube::Rule.weekly(value).day(:wednesday, :thursday, :friday))
  # end
# funtional fitness lundi 12h15-13h15 et mecredi 19h00-20h (2 weekly)
# pilates and flow mardi 12h15-13h15 et 19h00-20h00 et jeudi 18h30-19h30 (3 weekly)
# port de bras mardi 18h00-19h00 et vendredi 10h30 à 11h30 (2 weekly)
# yoga by core mercredi 18h00-19h00 jeudi 19h00-20h00 vendredi 12h15-13h15 (3 weekly)
# schedule.add_recurrence_rule IceCube::Rule.weekly(2).day(:monday, :wednesday
# schedule.add_recurrence_rule IceCube::Rule.weekly(3).day(:tuesday, :tuesday, :thursday))
# schedule.add_recurrence_rule IceCube::Rule.weekly(2).day(:tuesday, :friday))
# schedule.add_recurrence_rule IceCube::Rule.weekly(3).day(:wednesday, :thursday, :friday))

end
