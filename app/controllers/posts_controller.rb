class PostsController < ApplicationController

  def index
    @posts = Post.published.ordered.for_month(params[:year], params[:month]).paginate :per_page => 5, :page => params[:page]
    @archive_items = Post.archive_items
  end

  def show
    @commentable = Post.published.find_by_slug(params[:id])
    @comments = @commentable.comments.find :all, :order => "created_at ASC", :include => :user
    @comment = Comment.new
  end
end
