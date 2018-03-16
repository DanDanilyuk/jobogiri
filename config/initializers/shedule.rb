require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

# Proper Scraper Schedule
scheduler.cron '1 6-20/3 * * *' do
  200.times do
    p 'SCRAPER STARTED - RUFUS TASK'
  end 
  ScrapeIndeedJob.perform_now
end