class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable

  #refileで画像を使う設定
  attachment :profile_image

  #投稿機能
  has_many :outputs, dependent: :destroy

  
  #いいね機能
  has_many :favorites, dependent: :destroy

  def already_favorited?(output)
    self.favorites.exists?(output_id: output.id)
  end

  #フォロー機能
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end



  # scope :already_favorited?, -> query {
  #   self.favorites.exists?(output_id: query.id)
  # }
end
