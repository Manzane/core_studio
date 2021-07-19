class Lesson < ApplicationRecord
  serialize :recurring, Hash
  enum frequency_day: { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6 }
  belongs_to :category
  belongs_to :thematic
  has_many :bookings, dependent: :destroy
  validates :name, :start_time, presence: true
  validates :color, inclusion: { in: %w(pink blue yellow white green blue-green),
    message: "%{value} is not a valid color" }
  scope :future, -> { where("start_time > ?", DateTime.now) }
  scope :past, -> { where("start_time < ?", DateTime.now) }

  
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
    if self.start_time <  DateTime.now
      # raise
    return true
    else
      return false
    end  
  end

  def end_time
    return self.start_time + ( self.duration * 3600)
  end

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

    schedule
  end


  def create_recurring_events(day, end_date, start_time)

    from_date = start_time + 86400 
    # raise
    schedule(day).occurrences_between(from_date, end_date).each do |date|
      # raise
      Lesson.create!(thematic: thematic, category: category, name: name, capacity: capacity, start_time: date.change(offset: "+00:00", hour: start_time.hour, min: start_time.min), duration: duration, color: color)
    end
  end

end
