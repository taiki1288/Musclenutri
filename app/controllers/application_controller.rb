class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
      root_path # ログイン後に遷移するpathを設定
    end
    
    def after_sign_out_path_for(resource)
      new_user_session_path # ログアウト後に遷移するpathを設定
    end

    def check_guest
      email = resource&.email || params[:user][:email].downcase
      if email == 'guest@example.com'
        redirect_to root_path, alert: 'ゲストユーザーの編集・削除はできません'
      end
    end
    # protect_from_forgery with: :exception
    # before_action :configure_permitted_parameters, if: :devise_controller?
  
    # protected
  
    # def configure_permitted_parameters
    #   added_attrs = [ :email, :username, :password ]
    #   devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    #   devise_parameter_sanitizer.permit :sign_in, keys: [:email, :password]
    #   devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    # end
end
