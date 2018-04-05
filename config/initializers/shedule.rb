require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

# Proper Scraper Schedule
scheduler.cron '*/20 6-20 * * *' do
  ScrapeIndeedJob.perform_now
end

scheduler.cron '1 6-20/6 * * *' do
  CheckJobsJob.perform_now
end