class PostsController < ApplicationController

  def index
    @posts = Post.published.for_month(params[:year], params[:month]).paginate :per_page => 5, :page => params[:page]
    @archive_items = Post.archive_items
  end

  def show
    @post = Post.find :first, :conditions => ["published_at is NOT NULL AND slug = ?", params[:id]]
    @comments = @post.comments.find :all, :order => "created_at ASC", :include => :user
    @comment = Comment.new
  end
end
