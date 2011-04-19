require 'spec_helper'

describe Api::V2::ProblemsController do
  before :each do
    @api_key = Factory.create(:api_key, :key => 'key')
  end

  describe "index" do
    context "nearest" do
      it "returns empty json when no problems" do
        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => "nearest"

        response.body.should == '[]'
      end

      it "returns all problem details in the json" do
        municipality = Factory.create(:municipality)
        Factory.create(:problem, :description => "Problem 1", :id => 1, 
                       :longitude => 21, :latitude => 41,
                       :municipality => municipality)

        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => "nearest", 
                    :longitude => 21.2, 
                    :latitude => 41.2

        json = JSON.parse(response.body)

        json[0]['id'].should == 1
        json[0]['longitude'].should == '21'
        json[0]['latitude'].should == '41'
        json[0]['description'].should == 'Problem 1'
        json[0]['municipality'].should == 'Butel'
        json[0]['municipality_id'].should == municipality.id
        json[0]['category'].should == 'Abandoned vehicles'
        json[0]['url'].should match('problems/1')
        json[0]['created_at'].should_not be_nil
        json[0]['photo_small'].should match('1/s/rails.png')
        json[0]['photo_medium'].should match('1/m/rails.png')
      end

      it "returns json with ordered problems by distance" do
        Factory.create(:problem, :description => "Problem 1", :id => 1, 
                       :longitude => 21, :latitude => 41)
        Factory.create(:problem, :description => "Problem 2", :id => 2, 
                       :longitude => 22, :latitude => 42)

        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => "nearest", 
                    :longitude => 21.2, 
                    :latitude => 41.2

        json = JSON.parse(response.body)

        json[0]['id'].should == 1
        json[0]['longitude'].should == '21'
        json[0]['latitude'].should == '41'

        json[1]['id'].should == 2
        json[1]['longitude'].should == '22'
        json[1]['latitude'].should == '42'
      end

      it "returns json with ordered problems by distance in reverse" do
        Factory.create(:problem, :description => "Problem 1", :id => 1, 
                       :longitude => 21, :latitude => 41)
        Factory.create(:problem, :description => "Problem 2", :id => 2, 
                       :longitude => 22, :latitude => 42)

        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => "nearest",
                    :longitude => 21.7,
                    :latitude => 41.7

        json = JSON.parse(response.body)

        json[0]['id'].should == 2
        json[0]['longitude'].should == '22'
        json[0]['latitude'].should == '42'

        json[1]['id'].should == 1
        json[1]['longitude'].should == '21'
        json[1]['latitude'].should == '41'
      end
    end

    context "my" do
      it "returns empty json when there is no problems" do
        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => 'my'
        response.body.should == '[]'
      end

      it "returns all problems details in the json (when email on problem)" do
        Factory.create(:problem, :description => "Problem 1", :id => 1, 
                       :longitude => 21, :latitude => 41, :email => 'tester@popravi.mk')

        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => 'my',
                    :email => 'tester@popravi.mk'

        json = JSON.parse(response.body)

        json[0]['id'].should == 1
        json[0]['longitude'].should == '21'
        json[0]['latitude'].should == '41'
        json[0]['description'].should == 'Problem 1'
        json[0]['municipality'].should == 'Butel'
        json[0]['category'].should == 'Abandoned vehicles'
        json[0]['url'].should match('problems/1')
        json[0]['created_at'].should_not be_nil
        json[0]['photo_small'].should match('1/s/rails.png')
        json[0]['photo_medium'].should match('1/m/rails.png')
      end

      it "returns problems when problem assigned to user" do
        user = Factory.create(:user, :email => 'tester@popravi.mk')
        Factory.create(:problem, :description => "Problem 1", :id => 1, 
                       :longitude => 21, :latitude => 41, :user => user)

        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => 'my',
                    :email => 'tester@popravi.mk'

        json = JSON.parse(response.body)

        json[0]['id'].should == 1
        json[0]['longitude'].should == '21'
        json[0]['latitude'].should == '41'
        json[0]['description'].should == 'Problem 1'
        json[0]['municipality'].should == 'Butel'
        json[0]['category'].should == 'Abandoned vehicles'
        json[0]['url'].should match('problems/1')
        json[0]['created_at'].should_not be_nil
        json[0]['photo_small'].should match('1/s/rails.png')
        json[0]['photo_medium'].should match('1/m/rails.png')
      end

      it "returns json with ordered problems by distance" do
        Factory.create(:problem, :description => "Problem 1", :id => 1, 
                       :longitude => 21, :latitude => 41, :email => 'tester@popravi.mk')
        Factory.create(:problem, :description => "Problem 2", :id => 2, 
                       :longitude => 22, :latitude => 42, :email => 'tester@popravi.mk')

        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => 'my', 
                    :email => 'tester@popravi.mk'

        json = JSON.parse(response.body)

        json[0]['id'].should == 2
        json[0]['longitude'].should == '22'
        json[0]['latitude'].should == '42'

        json[1]['id'].should == 1
        json[1]['longitude'].should == '21'
        json[1]['latitude'].should == '41'
      end
    end

    context "latest" do
      it "returns empty json when there is no problems" do
        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => 'latest'

        response.body.should == '[]'
      end

      it "returns all problem details in the json" do
        Factory.create(:problem, :description => "Problem 1", :id => 1, 
                       :longitude => 21, :latitude => 41)

        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => 'latest'

        json = JSON.parse(response.body)

        json[0]['id'].should == 1
        json[0]['longitude'].should == '21'
        json[0]['latitude'].should == '41'
        json[0]['description'].should == 'Problem 1'
        json[0]['municipality'].should == 'Butel'
        json[0]['category'].should == 'Abandoned vehicles'
        json[0]['url'].should match('problems/1')
        json[0]['created_at'].should_not be_nil
        json[0]['photo_small'].should match('1/s/rails.png')
        json[0]['photo_medium'].should match('1/m/rails.png')
      end

      it "returns json with ordered problems by distance" do
        Factory.create(:problem, :description => "Problem 1", :id => 1, 
                       :longitude => 21, :latitude => 41)
        Factory.create(:problem, :description => "Problem 2", :id => 2, 
                       :longitude => 22, :latitude => 42)

        get :index, :format => 'json', :api_key => @api_key.key,
                    :type => 'latest'

        json = JSON.parse(response.body)

        json[0]['id'].should == 2
        json[0]['longitude'].should == '22'
        json[0]['latitude'].should == '42'

        json[1]['id'].should == 1
        json[1]['longitude'].should == '21'
        json[1]['latitude'].should == '41'
      end
    end
  end

  describe "create" do
    it "creates a problem" do
      municipality = Factory.create(:municipality)
      category = Factory.create(:category)

      post :create, :format => :json, :api_key => @api_key.key,
                    :problem => {
                      :description => 'problem 123',
                      :token => 123,
                      :longitude => 21,
                      :latitude => 42,
                      :email => 'test@example.com',
                      :category_id => category.id, 
                      :municipality_id => municipality.id
                    }

      response.should be_success

      json = JSON.parse(response.body)

      json['status'].should == 'ok'
    end

    it "returns error when no municipality" do
      category = Factory.create(:category)

      post :create, :format => :json, :api_key => @api_key.key, 
                    :problem => {
                      :description => 'problem 123',
                      :token => 123,
                      :longitude => 21,
                      :latitude => 42,
                      :email => 'test@example.com',
                      :category_id => category.id
                    }

      response.should be_success

      json = JSON.parse(response.body)

      json['status'].should  == "error"
      json['message'].should == "Municipality can't be blank"
      json['actions'].should == {"municipality"=>"sync"}
    end

    it "returns error when no category" do
      municipality = Factory.create(:municipality)

      post :create, :format => :json, :api_key => @api_key.key, 
                    :problem => {
                      :description => 'problem 123',
                      :token => 123,
                      :longitude => 21,
                      :latitude => 42,
                      :email => 'test@example.com',
                      :municipality_id => municipality.id
                    }

      response.should be_success

      json = JSON.parse(response.body)

      json['status'].should  == "error"
      json['message'].should == "Category can't be blank"
      json['actions'].should == {"category"=>"sync"}
    end

    it "returns error when no category and no municipality" do
      post :create, :format => :json, :api_key => @api_key.key, 
                    :problem => {
                      :description => 'problem 123',
                      :token => 123,
                      :longitude => 21,
                      :latitude => 42,
                      :email => 'test@example.com'
                    }

      response.should be_success

      json = JSON.parse(response.body)

      json['status'].should  == "error"
      json['message'].should == "Category can't be blank, Municipality can't be blank"
      json['actions'].should == {"category"=>"sync", "municipality"=>"sync"}
    end

    it "assigns user when user is logged in" do
      user = Factory.create(:user)
      login(user)
      post :create, :format => :json, :api_key => @api_key.key, 
                    :problem => {
                      :description => 'problem 123',
                      :token => 123,
                      :longitude => 21,
                      :latitude => 42,
                      :email => 'test@example.com'
                    }

      assigns(:problem).user.should == user
    end
  end

  describe "update" do
    it "can update problem by submiting a photo for it" do
      Factory.create(:problem, :photo => nil, :token => 123, :id => 1)

      put :update, :format => 'json', :api_key => @api_key.key, 
                   :id => 1, 
                   :token => 123, 
                   :photo => fixture_file_upload(File.join(Rails.root, 'public/images/rails.png'))


      response.should be_success

      json = JSON.parse(response.body)
      json['status'].should == 'ok'
    end

    it "cannot update problem submiting by other device id" do
      Factory.create(:problem, :photo => nil, :token => 123, :id => 1)

      put :update, :format => 'json', :api_key => @api_key.key, 
                   :id => 1, 
                   :token => 124, 
                   :photo => fixture_file_upload(File.join(Rails.root, 'public/images/rails.png'))


      response.should be_success

      json = JSON.parse(response.body)
      json['status'].should == 'error'
      json['type'].should == 'token'
    end
  end

  describe "update_status" do
    it "can't change the status when not logged in" do
      problem = Factory.create(:problem)

      put :update_status, :format => 'json', :api_key => @api_key.key,
                          :id => problem.id

      json = JSON.parse(response.body)
      json['status'].should == 'access_denied'
    end

    it "can't change the status when status param is blank" do
      problem = Factory.create(:problem)
      user = Factory.create(:user)
      login(user)

      put :update_status, :format => 'json', :api_key => @api_key.key,
                          :id => problem.id

      json = JSON.parse(response.body)
      json['status'].should == 'error'
    end

    it "can't change the status when status param is not in the list of allowed" do
      problem = Factory.create(:problem)
      user = Factory.create(:user)
      login(user)

      put :update_status, :format => 'json', :api_key => @api_key.key,
                          :id => problem.id, :status => 'unexisting'

      json = JSON.parse(response.body)
      json['status'].should == 'error'
    end

    it "can't change the status when user from other municipality" do
      municipality1 = Factory.create(:municipality)
      municipality2 = Factory.create(:municipality)
      user = Factory.create(:user, :municipality => municipality1)
      problem = Factory.create(:problem, :municipality => municipality2)
      login(user)
      put :update_status, :format => 'json', :api_key => @api_key.key,
                          :id => problem.id, :status => 'approved'

      json = JSON.parse(response.body)

      json['status'].should == 'error'
    end

    it "can change the status when status param is set" do
      municipality = Factory.create(:municipality)
      user = Factory.create(:user, :municipality => municipality)
      problem = Factory.create(:problem, :municipality => municipality)
      login(user)
      put :update_status, :format => 'json', :api_key => @api_key.key,
                          :id => problem.id, :status => 'approved'

      json = JSON.parse(response.body)

      json['status'].should == 'ok'
    end
  end
end
