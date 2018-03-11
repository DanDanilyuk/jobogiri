class AddStatusToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :state, :integer, default: 0
  end
end
