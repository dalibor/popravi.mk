require 'spec_helper'

describe Api::V1::CategoriesController do
  context "API V1 categories" do
    it "lists empty json when no categories" do
      get :index, :format => 'json'
      response.body.should == '[]'
    end

    it "lists hash with categories" do
      Factory.create(:category, :name => "Category 1", :id => 1)
      Factory.create(:category, :name => "Category 2", :id => 2)

      get :index, :format => 'json'
      response.body.should == '[{"name":"Category 1","id":1},{"name":"Category 2","id":2}]'
    end

    it "lists hash with categories ordered by position" do
      category1 = Factory.create(:category, :name => "Category 1", :id => 1)
      category2 = Factory.create(:category, :name => "Category 2", :id => 2)
      category2.move_higher

      get :index, :format => 'json'
      response.body.should == '[{"name":"Category 2","id":2},{"name":"Category 1","id":1}]'
    end
  end
end
