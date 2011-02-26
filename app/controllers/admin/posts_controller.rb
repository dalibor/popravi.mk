class Admin::PostsController < Admin::BaseController

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  def index
    @posts = Post.paginate :all, :order => "created_at DESC",
                           :per_page => 10, :page => params[:page]
  end

  def create
    @post = current_user.posts.new(params[:post])
    create!
  end
end
