class Admin::AttachmentsController < Admin::BaseController

  inherit_resources

  def index
    @attachments = current_user.attachments.order('name DESC').
      paginate(:page => params[:page], :per_page => 15)
  end

  protected

    def begin_of_association_chain
      current_user
    end
end
