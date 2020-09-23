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
      #ここでいいね順にソートできればよかったが、いいねの数なんてカラムはないのでソートできない
      # s = s.sort {|a,b| b.favorites.count <=> a.favorites.count}
    end

    if query[:narrow_down] == "1"
      s = s.left_joins(:user).joins('LEFT OUTER JOIN "relationships" ON "relationships"."follow_id" = "outputs"."user_id"')
      if query[:current_user_id].present?
        s = s.where(relationships:{user_id: query[:current_user_id]})
      end
    elsif query[:narrow_down] == "2"
      s = s.left_joins(:user).joins('LEFT OUTER JOIN "favorites" ON "favorites"."output_id" = "outputs"."id"').joins('LEFT OUTER JOIN "relationships" ON "relationships"."follow_id" = "favorites"."user_id"')
      if query[:current_user_id].present?
        s = s.where(relationships:{user_id: query[:current_user_id]})
      end
    end
    s
  }

  scope :ordered_asc, -> { order(created_at: :asc) }
  scope :ordered_desc, -> { order(created_at: :desc) }
  
  scope :get_followings_outputs, -> {
    left_joins(:users)
    .joins('LEFT OUTER JOIN "users" ON "users"."id" = "outputs"."user_id"')
    .where(users:{id: current_user.followings.to_a.id})
    .group('books.id')
  }



end
