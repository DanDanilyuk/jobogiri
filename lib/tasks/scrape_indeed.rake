desc 'Scrapes and validates Indeed Jobs'
task scrape_indeed: :environment do
  ScrapeIndeedJob.perform_now
end