class CheckJobsJob < ApplicationJob
  queue_as :default
  def perform
    Job.active.map do |job|
      begin
        if Net::HTTP.get_response(URI.parse(job.link)).is_a?(Net::HTTPSuccess)
          check_job = Nokogiri::HTML(open(job.link))
          if check_job.xpath("//p[@class='expired']").any?
            if job.users.any?
              job.update(state: 1)
            else
              job.delete
            end
          end
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
  end
end
