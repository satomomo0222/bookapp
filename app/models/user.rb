class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable

  attachment :profile_image

  has_many :outputs, dependent: :destroy
  has_many :favorites, dependent: :destroy



  def already_favorited?(output)
    self.favorites.exists?(output_id: output.id)
  end

  # scope :already_favorited?, -> query {
  #   self.favorites.exists?(output_id: query.id)
  # }
end
