require 'spec_helper'

describe MunicipalitiesController do

  it "should redirect on index action" do
    get 'index'
    response.should redirect_to(root_path)
  end

  it "should redirect on show action" do
    get 'show', :id => 1
    response.should redirect_to(root_path)
  end

end
