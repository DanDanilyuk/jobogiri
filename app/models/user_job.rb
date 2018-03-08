class UserJob < ApplicationRecord
  belongs_to :user
  belongs_to :job
  enum state: [:added, :applied, :responded, :accepted, :denied]
end
