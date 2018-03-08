class Job < ApplicationRecord
  # validates_presence_of :name, :location, :company, :body, :link
  validates_uniqueness_of :link
  has_many :user_jobs
  has_many :users, through: :user_jobs
end
