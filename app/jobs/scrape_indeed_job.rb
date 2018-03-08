class ScrapeIndeedJob < ApplicationJob
  queue_as :default
  require 'open-uri'

  def perform
    success = 0
    errors = 0
    duplicates = 0
    total_duplicates = 0
    url = 'https://www.indeed.com/jobs?as_and=&as_phr=&as_any=Ruby+Rails+Ruby+On+Rails+Angular+Lambda+Javascript+React+Front-End+Back-End+AWS+Sinatra+RSPEC&as_not=senior+sr+salesforce+ios+android&as_ttl=&as_cmp=&jt=all&st=&salary=&radius=25&l=&fromage=1&limit=50&sort=date&psf=advsrch'
      while url != nil && duplicates < 10
        doc = Nokogiri::HTML(open(url))
        doc.xpath("//a[@class='turnstileLink']").map do |posting|
          begin
            if duplicates < 10
              href = posting.attributes['href'].value
              if href.include? "clk?jk="
                link = 'https://www.indeed.com/viewjob?' + href[8..-1].split('&fccid')[0]
              else
                link = 'https://www.indeed.com/cmp' + href[8..-1].split('?fccid')[0]
              end
              if Job.where(link: link).any?
                p 'DUPLICATE POSTING FOUND'
                duplicates += 1
                total_duplicates += 1
              else
                doc2 = Nokogiri::HTML(open(link))
                posting_name = doc2.xpath("//b[@class='jobtitle']")[0].children.children.text
                posting_location = doc2.xpath("//input[@id='where']/@value").text
                posting_company = doc2.xpath("//td[1]/div/span[@class='company']").text
                posting_body = doc2.xpath("//table[@id='job-content']").text.delete("\n").delete("\t").delete("â\u0080¢").split('   -  save jobif (!window')[0].split("        ")[0..-2].last
                Job.create(name: posting_name, location: posting_location, company: posting_company, body: posting_body, link: link)
                p Job.count.to_s + ' Job Models Succesfully Created'
                success += 1
                duplicates = 0
              end
            end
          rescue
            errors += 1
            p errors.to_s + ' Current Errors'
            next
          end
        end
        if doc.css('div.pagination a').last.children.text.include? 'Next'
          url = 'https://www.indeed.com' + doc.css('div.pagination a').last.values.first
        else url = nil
        end
      end
    p "=================================="
    p success.to_s + ' Total Succeded'
    p errors.to_s + ' Total Errors'
    p total_duplicates.to_s + ' Total Duplicates'
  end
end