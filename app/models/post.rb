class Post < ApplicationRecord
  belongs_to :user 
  has_many :comments, dependent: :destroy
  
  # Polymorphic association for the image
  has_one_attached :image

  # Validations
  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true
end
