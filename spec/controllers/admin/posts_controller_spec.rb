require 'spec_helper'

describe Admin::PostsController do
  render_views

  #before(:each) do
    #create_admin_user_and_sign_in
  #end

  context "Access denied for non-admin users" do
    it "denies access for posts index action" do
      controller.should_not_receive(:index)
      get :index
    end

    it "denies access for posts new action" do
      controller.should_not_receive(:new)
      get :new
    end

    it "denies access for posts show action" do
      controller.should_not_receive(:show)
      get :show, :id => 1
    end

    it "denies access for posts edit action" do
      controller.should_not_receive(:edit)
      get :edit, :id => 1
    end

    it "denies access for posts create action" do
      controller.should_not_receive(:create)
      post :create
    end

    it "denies access for posts update action" do
      controller.should_not_receive(:update)
      get :update, :id => 1
    end

    it "denies access for posts destroy action" do
      controller.should_not_receive(:destroy)
      get :destroy, :id => 1
    end
  end
end
