module Admin
  class UsersController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    def resource_params
      params.require(:user).permit(:username,:profile,:profile_image,:twitter,:instagram,:facebook,:website,:output_ids, :email, :password, :password_confirmation)
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    #http://blog.319ring.net/2016/05/14/custom_view_administrate/ このページでは、strong parametersを下のように設定していたが、うまく動作しなかったので、上のようにパスワードをpermitしたが、脆弱性が心配
    # def permitted_attributes
      # dashboard.permitted_attributes << %w(password password_confirmation)
    # end
  end
end
