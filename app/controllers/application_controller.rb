class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.is_a?(Adminuser) || current_user.username?
      flash[:notice] = "ログインに成功しました" 
      root_url  #指定したいパスに変更
    else
      flash[:notice] = "ニックネームを登録してください" 
      profile_edit_path  #指定したいパスに変更
    end
  end

  def set_side
    books = Book.created_desc.first(2)
    @thisweek = books[1]
    @nextweek = books[0]
    @user = current_user
  end
end
