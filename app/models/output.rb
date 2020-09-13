class Output < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :favorites, dependent: :destroy

  validates_uniqueness_of :book_id, scope: :user_id

  scope :search_outputs, -> query {
    where('LOWER(outputs.body) LIKE LOWER(?)', "%#{query[:keyword]}%")
  }

  scope :ordered_asc, -> { order(created_at: :asc) }
  scope :ordered_desc, -> { order(created_at: :desc) }

end
