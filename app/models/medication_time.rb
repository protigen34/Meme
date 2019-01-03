class MedicationTime < ApplicationRecord
  include FlagShihTzu
  belongs_to :medication
  has_many :scheduled_alerts, :dependent => :destroy
  has_many :future_scheduled_alerts, ->(mt) {
      today_passed = mt.time_of_day.on(Date.today) <= Time.now
      start_date = !today_passed ? Date.today : Date.tomorrow
      self.where(:scheduled_date => start_date..(Date::INFINITY))
  }, :class_name => 'ScheduledAlert'

  validates :medication, :presence => true
  validates :day_of_week, :presence_of_flags => { :message => 'must be selected' }
  #validates :time_of_day, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :message => 'must be a time of day' }
  validates :time_of_day, :presence => true

  after_save :update_scheduled_alerts

  has_flags :column => 'day_of_week',
    1 => :sunday,
    2 => :monday,
    3 => :tuesday,
    4 => :wednesday,
    5 => :thursday,
    6 => :friday,
    7 => :saturday

  def time_of_day
    unless read_attribute(:time_of_day).nil?
      TimeOfDay.from_second_of_day read_attribute(:time_of_day)
    end
  end

  def time_of_day=(val)
    if val.nil?
      write_attribute(:time_of_day, nil)
    elsif val.is_a?(Numeric)
      write_attribute(:time_of_day, val)
    elsif val.is_a?(TimeOfDay)
      write_attribute(:time_of_day, val.to_i)
    elsif val.is_a?(Time)
      write_attribute(:time_of_day, val.to_time_of_day.to_i)
    elsif val.is_a?(String) && TimeOfDay.parsable?(val)
      write_attribute(:time_of_day, TimeOfDay.parse(val))
    else
      raise ArgumentError, "Invalid time of day (#{val.inspect})"
    end
  end

  def get_toast_data
    toast_data = {}
    toast_data[:title] = "Time to take your #{medication.name}!"
    toast_data[:text] = "Reminder to take #{medication.quantity} " +
    "#{medication.unit} of #{medication.name} " +
    "at #{time_of_day.strftime("%I:%M %p")} on #{Date.today.to_s}."
    if !medication.directions.blank?
      toast_data[:text] += " (Directions: #{medication.directions})"
    end
    toast_data
  end

  def days_of_week
    self.selected_flags('day_of_week')
  end

  def upcoming_dates(through = 7.days.from_now)
    today_passed = time_of_day.on(Date.today) <= Time.now
    start_date = !today_passed ? Date.today : Date.tomorrow
    dates = (start_date..(through.to_date)).to_a
    dates.select! do |date|
      weekday = Date::DAYNAMES[date.wday].downcase.to_sym
      self.days_of_week.include? weekday
    end
    dates.freeze
  end

  def update_scheduled_alerts(through = 7.days.from_now)
    future_dates = upcoming_dates(through)
    dates_scheduled = self.future_scheduled_alerts
    dates_to_schedule = future_dates - dates_scheduled.map(&:scheduled_date)
    extraneous_dates_scheduled = dates_scheduled.map(&:scheduled_date) - future_dates
    extraneous_dates_scheduled.each do |extraneous_date|
      self.scheduled_alerts.where(:scheduled_date => extraneous_date).first.try(&:destroy)
    end
    dates_to_schedule.each do |date|
      new_scheduled_date = self.scheduled_alerts.build(:scheduled_date => date)
      new_scheduled_date.save
    end
  end

end
