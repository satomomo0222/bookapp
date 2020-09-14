class Output < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :favorites, dependent: :destroy

  validates_uniqueness_of :book_id, scope: :user_id

  scope :search_outputs, -> query {
    s = select("outputs.*")
    if query[:keyword].present?
      s = s.where('LOWER(outputs.body) LIKE LOWER(?)', "%#{query[:keyword]}%")
    end
    if query[:sort_order].blank? || query[:sort_order] == "0"
      s = s.ordered_desc
    elsif query[:sort_order] == "1"
      s = s.ordered_asc
    elsif query[:sort_order] == "2"
      # s = s.sort {|a,b| b.favorites.count <=> a.favorites.count}
    end
    s
  }

  scope :ordered_asc, -> { order(created_at: :asc) }
  scope :ordered_desc, -> { order(created_at: :desc) }

  scope :get_user_outputs, -> query {
    left_joins(:users)
    .joins('LEFT OUTER JOIN "users" ON "users"."id" = "outputs"."user_id"')
    .where(users:{id: query[:user_id]})
    .group('books.id')
  }

end
