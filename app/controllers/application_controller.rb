class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if current_user.username?
      flash[:notice] = "ログインに成功しました" 
      root_url  #指定したいパスに変更
    else
      flash[:notice] = "ニックネームを登録してください" 
      profile_edit_path  #指定したいパスに変更
    end
  end
end
