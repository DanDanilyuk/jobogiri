desc 'Validates Indeed Jobs'
task check_jobs: :environment do
  CheckJobsJob.perform_now
end