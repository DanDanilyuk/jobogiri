require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

# Proper Scraper Schedule
scheduler.cron '1 6-20 * * *' do
  ScrapeIndeedJob.perform_now
end