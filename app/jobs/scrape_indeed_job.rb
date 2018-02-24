class ScrapeIndeedJob < ApplicationJob
  queue_as :default
  require 'open-uri'

  def perform
    url = 'https://www.indeed.com/jobs?as_and=&as_phr=&as_any=%28Ruby+or+Rails+or+Ruby+On+Rails+or+Angular+or+Lambda+or+Javascript+or+React+or+Front-End+or+Back-End+or+AWS+or+Sinatra+or+RSPEC+or+QA+or+Testing%29&as_not=&as_ttl=&as_cmp=&jt=fulltime&st=&salary=&radius=25&l=&fromage=1&limit=50&sort=date&psf=advsrch'
    doc = Nokogiri::HTML(open(url))
    doc.xpath("//a[@class='turnstileLink']").map do |posting|
      begin
        title = posting.attributes['title'].value
        href = posting.attributes['href'].value
        if href.include? "company"
          link = 'https://www.indeed.com/cmp' + href[8..-1].split('?fccid')[0] + ' '
        else
          link = 'https://www.indeed.com/viewjob?' + href[8..-1].split('&fccid')[0] + ' '
        end
      rescue
        next
      end
    end
  end
end
