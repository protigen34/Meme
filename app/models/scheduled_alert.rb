class ScheduledAlert < ApplicationRecord
  belongs_to :delayed_job_record, :class_name => "::Delayed::Job", :foreign_key  => :delayed_job_id
  belongs_to :medication_time
  validates :medication_time, :delayed_job, :presence => true
  delegate :medication, :to => :medication_time, :allow_nil => true
  validates :scheduled_date, :presence => true, :uniqueness => { :scope => :medication_time }

  before_validation :create_missing_delayed_job
  after_destroy :destroy_delayed_job

  def delayed_job
    delayed_job_record.try(:payload_object)
  end

  def future?
    today_passed = medication_time.time_of_day.on(Date.today) <= Time.now
    start_date = !today_passed ? Date.today : Date.tomorrow
    self.scheduled_date >= start_date
  end

private
  def create_missing_delayed_job
    return unless self.delayed_job.nil?
    time = self.medication_time.time_of_day.on scheduled_date
    job = AlertJob.new(self.medication_time)
    job.scheduled_at = time
    job.enqueue
    self.delayed_job_id = job.provider_job_id
  end

  def destroy_delayed_job
    return if self.delayed_job_record.nil?
    throw :abort unless future?
    self.delayed_job_record.destroy
  end
end
