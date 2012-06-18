class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied, :with => :render_403

  private
  def render_403
    return if performed?
    if user_signed_in?
      respond_to do |format|
        format.html {render :template => 'page/403', :status => 403}
        format.xml {render :template => 'page/403', :status => 403}
        format.json { render :text => '{"error": "forbidden"}' }
      end
    else
      respond_to do |format|
        format.html {redirect_to new_user_session_url}
        format.xml {render :template => 'page/403', :status => 403}
        format.json { render :text => '{"error": "forbidden"}' }
      end
    end
  end
end
