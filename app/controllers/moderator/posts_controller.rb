class Moderator::PostsController < Moderator::BaseController

  inherit_resources
  respond_to :html

  def index
    @posts = begin_of_association_chain.posts.ordered.
               paginate :per_page => 10, :page => params[:page]
  end

  def create
    @post = current_user.posts.new(params[:post])
    create!
  end

  def update
    @post = current_user.municipality.posts.find(params[:id], :readonly => false)
    update!
  end

  protected
  def begin_of_association_chain
    current_user.municipality
  end
end
