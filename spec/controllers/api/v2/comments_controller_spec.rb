require 'spec_helper'

describe Api::V2::CommentsController do
  before :each do
    @api_key = Factory.create(:api_key, :key => 'key')
  end

  describe "index" do
    it "returns empty json when no comments" do
      problem = Factory.create(:problem)
      get :index, :format => 'json', :api_key => @api_key.key, 
                  :problem_id => problem.id

      response.body.should == '[]'
    end

    it "returns all comments details in the json" do
      problem = Factory.create(:problem)
      comment = Factory.create(:comment, :commentable => problem, 
                               :name => 'Test User', :content => 'Test comment')

      get :index, :format => 'json', :api_key => @api_key.key, 
                  :problem_id => problem.id

      json = JSON.parse(response.body)

      json[0]['user'].should == 'Test User'
      json[0]['content'].should == 'Test comment'
      json[0]['created_at'].should_not be_nil
    end
  end

  describe "create comment" do

    it "can't create comments when content is blank" do
      problem = Factory.create(:problem)
      post :create, :format => 'json', :api_key => @api_key.key,
                    :problem_id => problem.id

      json = JSON.parse(response.body)

      json['status'].should == 'error'
    end

    it "can create comment" do
      problem = Factory.create(:problem)
      post :create, :format => 'json', :api_key => @api_key.key,
                    :problem_id => problem.id, :content => 'test comment'

      json = JSON.parse(response.body)

      json['status'].should == 'ok'
      json['comment']['user'].should == 'Анонимен корисник'
      json['comment']['content'].should == 'test comment'
      json['comment']['created_at'].should_not be_nil
    end

    it "assigns user_id to comment when user is logged in" do
      user = Factory.create(:user)
      login(user)
      problem = Factory.create(:problem)
      post :create, :format => 'json', :api_key => @api_key.key,
                    :problem_id => problem.id, :content => 'test comment'

      json = JSON.parse(response.body)

      json['status'].should == 'ok'

      Comment.first.user.should == user
    end
  end
end
