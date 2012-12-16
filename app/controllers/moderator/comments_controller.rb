class Moderator::CommentsController < Moderator::BaseController

  before_filter :load_comment, :except => :index

  def index
    @comments = current_user.comments.
      paginate :per_page => 10, :page => params[:page]
  end

  def show
  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      redirect_to moderator_comment_path(@comment), :notice => "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to moderator_comments_path, :notice => "Comment was successfully deleted."
  end

  private
  def load_comment
    @comment = current_user.comments.find(params[:id])
  end
end
