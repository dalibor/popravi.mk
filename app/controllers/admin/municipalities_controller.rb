class Admin::MunicipalitiesController < Admin::BaseController

  inherit_resources
  respond_to :html

  def index
    @municipalities = Municipality.includes(:region).
      paginate :per_page => 10, :page => params[:page]
  end

  def create
    create! do |success, failure|
      flash[:notice] = "Municipality was successfully created"
      success.html { redirect_to admin_municipalities_url }
    end
  end

  def update
    update! do |success, failure|
      flash[:notice] = "Municipality was successfully updated"
      success.html { redirect_to admin_municipalities_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_municipalities_url }
    end
  end
end
