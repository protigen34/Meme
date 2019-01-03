namespace :alerts do
  desc "Schedule medication alerts upto N days into future (default: 7)"
  task :schedule, [:days_into_future] => [:environment] do |t, args|
    args.with_defaults(:days_into_future => 7)
    MedicationTime.all.each do |mt|
      mt.update_scheduled_alerts(args.days_into_future.days.from_now)
    end
  end
end