class Book < ApplicationRecord
  has_many :outputs, dependent: :destroy
  attachment :book_image

  scope :created_desc, -> { order(created_at: :desc) }
end
