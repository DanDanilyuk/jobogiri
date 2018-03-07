class CreateUserJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_jobs do |t|
      t.integer 'user_id'
      t.integer 'job_id'
      t.integer 'state', default: 0
      t.string 'comments'

      t.timestamps
    end
  end
end
