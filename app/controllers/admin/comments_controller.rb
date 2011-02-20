class Admin::CommentsController < Admin::BaseController

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  def index
    @comments = Comment.paginate :all, :order => "id DESC",
                                 :include => :user,
                                 :per_page => 10, :page => params[:page]
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
    @comment.send(:attributes=, params[:comment], false)

    update! do |success, failure|
      flash[:notice] = "Comment was successfully updated"
      success.html { redirect_to admin_comments_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_comments_url }
    end
  end
end
