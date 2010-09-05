class Admin::PostsController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  # Layout
  layout "admin"

  def index
    @posts = Post.paginate :per_page => 10, :page => params[:page], :order => "id DESC"
  end

  def create
    @post = current_user.posts.new(params[:post])

    create! do |success, failure|
      flash[:notice] = "Post was successfully created"
      success.html { redirect_to admin_posts_url }
    end
  end

  def update
    update! do |success, failure|
      flash[:notice] = "Post was successfully updated"
      success.html { redirect_to admin_posts_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_posts_url }
    end
  end

  protected
  def resource
    @post = Post.find_by_slug(params[:id])
  end
end
