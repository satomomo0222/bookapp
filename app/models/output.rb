class Output < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

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


  # 通知機能
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      output_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
      # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      temp_ids = Comment.select(:user_id).where(output_id: id).where.not(user_id: current_user.id).distinct
      temp_ids.each do |temp_id|
          save_notification_comment!(current_user, comment_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        output_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
  end
  

end
