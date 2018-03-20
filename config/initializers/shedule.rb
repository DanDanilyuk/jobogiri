require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

# Proper Scraper Schedule
scheduler.chron '1 6-20 * * *' do
  ScrapeIndeedJob.perform_now
end