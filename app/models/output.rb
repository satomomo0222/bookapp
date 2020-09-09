class Output < ApplicationRecord
  belongs_to :user
  belongs_to :book



  scope :search_outputs, -> query {
    where('LOWER(outputs.body) LIKE LOWER(?)', "%#{query[:keyword]}%")
  }

  scope :ordered_asc, -> { order(created_at: :asc) }
  scope :ordered_desc, -> { order(created_at: :desc) }
end
