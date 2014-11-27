class PagesController < ApplicationController
  def home
  end

  before_filter :require_login

  def accounts
  	@users = User.all
  end
  

private

  def require_login
    unless user_signed_in?
      redirect_to new_user_session_path 
    end
  end



end
