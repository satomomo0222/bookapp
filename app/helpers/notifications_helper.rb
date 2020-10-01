module NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_output = link_to 'あなたの投稿', output_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.username, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.username, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:output_path(notification.output_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @visiter_comment)&.body
          tag.a(@visiter.username, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:output_path(notification.output_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end

