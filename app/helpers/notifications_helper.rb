module NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_output = link_to 'あなたの投稿', output_path(notification), style:"font-weight: bold; color:white;"
    @visiter_comment = notification.comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.username, href:user_path(@visiter), style:"font-weight: bold; color:hsl(48, 100%, 67%); margin:0 5px;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.username, href:user_path(@visiter), style:"font-weight: bold; color:hsl(48, 100%, 67%); margin:0 5px;")+"が"+tag.a('あなたの投稿', href:output_path(notification.output_id), style:"font-weight: bold; color:hsl(48, 100%, 67%); margin:0 5px;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @visiter_comment)&.body
          if Output.find_by(id: notification.output_id).user_id == notification.visited_id
            tag.a(@visiter.username, href:user_path(@visiter), style:"font-weight: bold; color:hsl(48, 100%, 67%); margin:0 5px;")+"が"+tag.a('あなたの投稿', href:output_path(notification.output_id), style:"font-weight: bold; color:hsl(48, 100%, 67%); margin:0 5px;")+"にコメントしました"
          else
            tag.a(@visiter.username, href:user_path(@visiter), style:"font-weight: bold; color:hsl(48, 100%, 67%); margin:0 5px;")+"が"+tag.a('あなたがコメントした投稿', href:output_path(notification.output_id), style:"font-weight: bold; color:hsl(48, 100%, 67%); margin:0 5px;")+"にコメントしました"
          end
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end