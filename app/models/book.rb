class Book < ApplicationRecord
  has_many :outputs, dependent: :destroy
  attachment :book_image

  scope :created_desc, -> { order(created_at: :desc) }

  scope :get_user_books, -> query {
    left_joins(:outputs)
    .joins('LEFT OUTER JOIN "users" ON "users"."id" = "outputs"."user_id"')
    .where(users:{id: query[:user_id]})
    .group('books.id')
  }

  scope :search_books, -> query {
    where('LOWER(books.title) LIKE LOWER(?)', "%#{query[:keyword]}%")
  }
  
end
