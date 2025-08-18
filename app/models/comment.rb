class Comment < ApplicationRecord
  belongs_to :post

  # Validation
  validates :body, presence: true
end
