class Admin::PostsController < Admin::BaseController

  inherit_resources
  respond_to :html

  def index
    @posts = Post.ordered.paginate :per_page => 10, :page => params[:page]
  end

  def create
    @post = current_user.posts.new(params[:post])
    create!
  end
end
