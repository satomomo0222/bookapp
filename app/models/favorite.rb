class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :output

  validates_uniqueness_of :output_id, scope: :user_id

  scope :get_user_favorites, -> query {
    
    
  }
  

  
  s = s + output.favorites.count


end
