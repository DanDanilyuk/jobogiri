class UserJob < ApplicationRecord
  belongs_to :user
  belongs_to :job
  enum state: [:added, :applied, :responded, :accepted, :denied]
  validates :user_id, uniqueness: { scope: :job_id,
    message: "You cant favorite the same job!" }
end
