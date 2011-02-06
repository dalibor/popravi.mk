require 'spec_helper'

describe Api::V1::MunicipalitiesController do
  context "API V1 municipalities" do
    it "lists empty json when no municipalities" do
      get :index, :format => 'json'
      response.body.should == '[]'
    end

    it "lists hash with categories" do
      Factory.create(:municipality, :name => "Municipality 1", :id => 1)
      Factory.create(:municipality, :name => "Municipality 2", :id => 2)

      get :index, :format => 'json'
      response.body.should == '[{"name":"Municipality 1","id":1},{"name":"Municipality 2","id":2}]'
    end

    it "lists json with municipalities ordered by name" do
      Factory.create(:municipality, :name => "Municipality 2", :id => 1)
      Factory.create(:municipality, :name => "Municipality 1", :id => 2)

      get :index, :format => 'json'
      response.body.should == '[{"name":"Municipality 1","id":2},{"name":"Municipality 2","id":1}]'
    end
  end
end
