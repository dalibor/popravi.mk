require 'spec_helper'

describe Admin::CountriesController do
  integrate_views

  #before(:each) do
    #create_admin_user_and_sign_in
  #end

  context "Access denied for non-admin users" do
    it "denies access for countries index action" do
      controller.should_not_receive(:index)
      get :index
    end

    it "denies access for countries new action" do
      controller.should_not_receive(:new)
      get :new
    end

    it "denies access for countries show action" do
      controller.should_not_receive(:show)
      get :show, :id => 1
    end

    it "denies access for countries edit action" do
      controller.should_not_receive(:edit)
      get :edit, :id => 1
    end

    it "denies access for countries create action" do
      controller.should_not_receive(:create)
      post :create
    end

    it "denies access for countries update action" do
      controller.should_not_receive(:update)
      get :update, :id => 1
    end

    it "denies access for countries destroy action" do
      controller.should_not_receive(:destroy)
      get :destroy, :id => 1
    end
  end
end
