require 'spec_helper'

describe Api::V2::CategoriesController do
  before :each do
    @api_key = Factory.create(:api_key, :key => 'key')
  end

  it "returns empty json when no categories" do
    get :index, :format => 'json', :api_key => @api_key.key
    response.body.should == '[]'
  end

  it "returns json with categories" do
    Factory.create(:category, :name => "Category 1", :id => 1)
    Factory.create(:category, :name => "Category 2", :id => 2)

    get :index, :format => 'json', :api_key => @api_key.key
    response.body.should == '[{"name":"Category 1","id":1},{"name":"Category 2","id":2}]'
  end

  it "returns json with categories ordered by position" do
    category1 = Factory.create(:category, :name => "Category 1", :id => 1)
    category2 = Factory.create(:category, :name => "Category 2", :id => 2)
    category2.move_higher

    get :index, :format => 'json', :api_key => @api_key.key
    response.body.should == '[{"name":"Category 2","id":2},{"name":"Category 1","id":1}]'
  end
end
