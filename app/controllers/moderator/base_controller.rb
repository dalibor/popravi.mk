class Moderator::BaseController < ApplicationController

  before_filter :verify_moderator
  layout "moderator"

  private
  def verify_moderator
    raise AccessDenied unless current_user && current_user.is_moderator?
  end
end
