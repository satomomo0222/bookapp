class Book < ApplicationRecord

  has_many :outputs, dependent: :destroy
  attachment :book_image
end
