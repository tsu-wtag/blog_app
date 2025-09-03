class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # Validation
  validates :body, presence: true
end
