class Municipality::PostsController < Municipality::BaseController
  before_filter :load_municipality

  def index
    @posts = @municipality.posts.published.ordered.for_month(params[:year], params[:month]).paginate :per_page => 5, :page => params[:page]
    @archive_items = @municipality.posts.archive_items
  end

  def show
    @commentable = @municipality.posts.published.find_by_slug!(params[:id])
    @comments = @commentable.comments.order("created_at ASC").includes(:user)
    @comment = Comment.new
  end
end
