class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :location
      t.string :company
      t.string :body
      t.string :link
      t.timestamps
    end
  end
end