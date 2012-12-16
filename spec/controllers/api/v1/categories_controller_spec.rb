require 'spec_helper'

describe Api::V1::CategoriesController do
  it "returns empty json when no categories" do
    get :index, :format => 'json'

    json = JSON.parse(response.body)
    json.should be_empty
  end

  it "returns json with categories" do
    create(:category, :name => "Category 1", :id => 1)
    create(:category, :name => "Category 2", :id => 2)

    get :index, :format => 'json'

    json = JSON.parse(response.body)
    json[0]['name'].should == 'Category 1'
    json[0]['id'].should == 1
    json[1]['name'].should == 'Category 2'
    json[1]['id'].should == 2
  end

  it "returns json with categories ordered by position" do
    category1 = create(:category, :name => "Category 1", :id => 1)
    category2 = create(:category, :name => "Category 2", :id => 2)
    category2.move_higher

    get :index, :format => 'json'

    json = JSON.parse(response.body)
    json[0]['name'].should == 'Category 2'
    json[0]['id'].should == 2
    json[1]['name'].should == 'Category 1'
    json[1]['id'].should == 1
  end
end
