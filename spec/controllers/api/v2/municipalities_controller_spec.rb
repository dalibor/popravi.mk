require 'spec_helper'

describe Api::V2::MunicipalitiesController do
  before :each do
    @api_key = Factory.create(:api_key, :key => 'key')
  end

  it "returns empty json when no municipalities" do
    get :index, :format => 'json', :api_key => @api_key.key
    response.body.should == '[]'
  end

  it "returns json with categories" do
    Factory.create(:municipality, :name => "Municipality 1", :id => 1)
    Factory.create(:municipality, :name => "Municipality 2", :id => 2)

    get :index, :format => 'json', :api_key => @api_key.key
    response.body.should == '[{"name":"Municipality 1","id":1},{"name":"Municipality 2","id":2}]'
  end

  it "returns json with municipalities ordered by name" do
    Factory.create(:municipality, :name => "Municipality 2", :id => 1)
    Factory.create(:municipality, :name => "Municipality 1", :id => 2)

    get :index, :format => 'json', :api_key => @api_key.key
    response.body.should == '[{"name":"Municipality 1","id":2},{"name":"Municipality 2","id":1}]'
  end
end
