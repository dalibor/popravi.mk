require 'spec_helper'

describe Api::V2::MunicipalitiesController do
  before :each do
    @api_key = create(:api_key, :key => 'key')
  end

  it "returns empty json when no municipalities" do
    get :index, :format => 'json', :api_key => @api_key.key
    response.body.should == '[]'
  end

  it "returns json with categories" do
    create(:municipality, :name => "Municipality 1", :id => 1)
    create(:municipality, :name => "Municipality 2", :id => 2)

    get :index, :format => 'json', :api_key => @api_key.key

    json = JSON.parse(response.body)
    json[0]['name'].should == 'Municipality 1'
    json[0]['id'].should == 1
    json[1]['name'].should == 'Municipality 2'
    json[1]['id'].should == 2
  end

  it "returns json with municipalities ordered by name" do
    create(:municipality, :name => "Municipality 2", :id => 1)
    create(:municipality, :name => "Municipality 1", :id => 2)

    get :index, :format => 'json', :api_key => @api_key.key

    json = JSON.parse(response.body)
    json[0]['name'].should == 'Municipality 1'
    json[0]['id'].should == 2
    json[1]['name'].should == 'Municipality 2'
    json[1]['id'].should == 1
  end
end
