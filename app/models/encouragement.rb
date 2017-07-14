class Encouragement < ApplicationRecord
  belongs_to :user
  belongs_to :note

  validates :message, presence: true
end
