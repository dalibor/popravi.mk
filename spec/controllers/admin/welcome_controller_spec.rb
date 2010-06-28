require 'spec_helper'

describe Admin::WelcomeController do
  integrate_views

  #before(:each) do
    #create_admin_user_and_sign_in
  #end

  context "Access denied for non-admin users" do
    it "denies access for categories index action" do
      controller.should_not_receive(:index)
      get :index
    end
  end
end
