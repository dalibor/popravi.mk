require 'spec_helper'

describe Admin::WelcomeController do
  render_views

  context "Access denied for non-admin users" do
    it "denies access for categories index action" do
      controller.should_not_receive(:index)
      get :index
    end
  end
end
