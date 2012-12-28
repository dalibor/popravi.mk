class PostsController < ApplicationController

  def index
    @posts = Post.from_admins.published.ordered.for_month(params[:year], params[:month]).paginate :per_page => 5, :page => params[:page]
    @archive_items = Post.archive_items
  end

  def show
    @commentable = Post.from_admins.published.find_by_slug!(params[:id])
    @comments = @commentable.comments.order("created_at ASC").includes(:user)
    @comment = Comment.new
    @posts = Post.from_admins.published.ordered.limit(5)
  end
end
