class Admin::CommentsController < Admin::BaseController

  inherit_resources

  respond_to :html

  def index
    @comments = Comment.ordered.includes(:user).
      paginate :per_page => 10, :page => params[:page]
  end

  def create
    @comment = Comment.new
    @comment.send(:attributes=, params[:comment], false)

    create! do |success, failure|
      success.html do
        flash[:notice] = "Comment was successfully created"
        redirect_to admin_comments_url
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment], :without_protection => true)
      flash[:notice] = "Comment was successfully updated"
      redirect_to admin_comments_url
    else
      render :edit
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_comments_url }
    end
  end
end
