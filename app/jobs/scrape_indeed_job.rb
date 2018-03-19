class ScrapeIndeedJob < ApplicationJob
  queue_as :default
  require 'open-uri'

  def perform
    duplicates = 0
    start = Time.now
    url = 'https://www.indeed.com/jobs?as_and=&as_phr=%22developer%22&as_any=Ruby+Rails+Ruby-On-Rails+ROR+Angular+Lambda+Javascript+React+Front-End+Back-End+AWS+Sinatra+RSPEC+HTML+CSS&as_not=senior+sr+salesforce+ios+android+.net+Java&as_ttl=&as_cmp=&jt=all&st=&salary=&radius=25&fromage=1&limit=50&sort=date&psf=advsrch'
    while url != nil && duplicates < 10
    # while url != nil && duplicates < 10 && Job.count < 100
      doc = Nokogiri::HTML(open(url))
      doc.xpath("//a[@class='turnstileLink']").map do |posting|
        begin
          if duplicates < 10
          # if duplicates < 10 && Job.count < 100
            href = posting.attributes['href'].value
            if href.include? 'clk?jk='
              link = 'https://www.indeed.com/viewjob?' + href[8..-1].split('&fccid')[0]
            else
              link = 'https://www.indeed.com/cmp' + href[8..-1].split('?fccid')[0]
            end
            if Job.where(link: link).any?
              p 'DUPLICATE POSTING FOUND'
              duplicates += 1
            else
              doc2 = Nokogiri::HTML(open(link))
              posting_name = doc2.xpath("//b[@class='jobtitle']")[0].children.children.text
              posting_location = doc2.xpath("//input[@id='where']/@value").text
              posting_company = doc2.xpath("//td[1]/div/span[@class='company']").text
              posting_body = doc2.xpath("//table[@id='job-content']").to_html.split("result-link-bar-container").first[0..-47].split("snip")[1][3..-1].delete("\n").delete("\t").delete("â\u0080¢")
              Job.create(name: posting_name, location: posting_location, company: posting_company, body: posting_body, link: link)
              p Job.count.to_s + ' Job Models Succesfully Created'
              duplicates = 0
            end
          end
        rescue
          next
        end
      end
      if doc.css('div.pagination a').last.children.text.include? 'Next' || duplicates < 10
        url = 'https://www.indeed.com' + doc.css('div.pagination a').last.values.first
      else url = nil
      end
    end
    # Goes through all jobs and removes all unsaved jobs
    p 'BEGIN VALIDATING JOBS'
    Job.active.map do |job|
      begin
        if Net::HTTP.get_response(URI.parse(job.link)).is_a?(Net::HTTPSuccess)
          next
        elsif job.users.any?
          job.update(state: 1)
        else
          job.delete
        end
        next
      rescue
        if job.users.any?
          job.update(state: 1)
        else
          job.delete
        end
        next
      end
    end
    p '=================================='
    finish = Time.now
    p 'Total Scraper Runtime: ' + (finish - start).to_s
  end
end
