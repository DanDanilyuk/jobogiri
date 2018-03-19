require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

# Proper Scraper Schedule
scheduler.every 5.minutes do
  200.times do
    p 'SCRAPER STARTED - RUFUS TASK'
  end 
  ScrapeIndeedJob.perform_now
end