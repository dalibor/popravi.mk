require 'spec_helper'

describe Admin::CategoriesController do
  render_views

  #before(:each) do
    #create_admin_user_and_sign_in
  #end

  context "Access denied for non-admin users" do
    it "denies access for categories index action" do
      controller.should_not_receive(:index)
      get :index
    end

    it "denies access for categories new action" do
      controller.should_not_receive(:new)
      get :new
    end

    it "denies access for categories show action" do
      controller.should_not_receive(:show)
      get :show, :id => 1
    end

    it "denies access for categories edit action" do
      controller.should_not_receive(:edit)
      get :edit, :id => 1
    end

    it "denies access for categories create action" do
      controller.should_not_receive(:create)
      post :create
    end

    it "denies access for categories update action" do
      controller.should_not_receive(:update)
      get :update, :id => 1
    end

    it "denies access for categories destroy action" do
      controller.should_not_receive(:destroy)
      get :destroy, :id => 1
    end
  end
end
