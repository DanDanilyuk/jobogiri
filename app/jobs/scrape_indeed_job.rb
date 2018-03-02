class ScrapeIndeedJob < ApplicationJob
  queue_as :default
  require 'open-uri'

  def perform
    pagination_number = 0
    # url = 'https://www.indeed.com/jobs?q=%28Ruby+or+Rails+or+Ruby+or+On+or+Rails+or+Angular+or+Lambda+or+Javascript+or+React+or+Front-End+or+Back-End+or+AWS+or+Sinatra+or+RSPEC+or+QA+or+Testing%29&sort=date&limit=50&fromage=1&radius=25&start=' + pagination_number.to_s
    doc = Nokogiri::HTML(open(url))
    success = 0
    errors = 0
      while pagination_number != nil
        doc.xpath("//a[@class='turnstileLink']").map do |posting|
          begin
            href = posting.attributes['href'].value
            if href.include? "clk?jk="
              link = 'https://www.indeed.com/viewjob?' + href[8..-1].split('&fccid')[0]
            else
              link = 'https://www.indeed.com/cmp' + href[8..-1].split('?fccid')[0]
            end
            doc2 = Nokogiri::HTML(open(link))
            name = doc2.xpath("//b[@class='jobtitle']")[0].children.children.text
            location = doc2.xpath("//td[1]/div/span[@class='location']").text
            company = doc2.xpath("//td[1]/div/span[@class='company']").text
            body = doc2.xpath("//table[@id='job-content']").text.delete("\n").delete("\t").delete("â\u0080¢").split('   -  save jobif (!window')[0].split("        ")[0..-2].last
            success += 1
            Job.create(name: name, location: location, company: company, body: body, link: link)
            p success.to_s + ' Job Posting Succesfully Scraped'
            p Job.count.to_s + ' Job Models Succesfully Created'
          rescue
            errors += 1
            p errors.to_s + ' Current Errors'
            next
          end
          if doc.search(".np").first.text != '« Previous'
            pagination_number += 50
          else pagination_number = nil
          end
        end
      end
    p success.to_s + ' Total Succeded'
    p errors.to_s + ' Total Errors'
  end
end