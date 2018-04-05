desc 'Scrapes Indeed Jobs'
task scrape_indeed: :environment do
  ScrapeIndeedJob.perform_now
end