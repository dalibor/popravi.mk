require 'spec_helper'

describe Api::V2::SessionsController do
  before :each do
    @api_key = Factory.create(:api_key, :key => 'key')
  end

  describe "login" do
    it "can't login when invalid email" do
      post :create, :format => 'json', :api_key => @api_key.key,
           :email => 'invalid'

      json = JSON.parse(response.body)

      json['status'].should == "error"
      json['message'].should == "Невалиден email или лозинка"
    end

    it "can't login when valid email and invalid password" do
      user = Factory.create(:user, :email => 'tested@popravi.mk', 
                                   :password => 'password')

      post :create, :format => 'json', :api_key => @api_key.key,
           :email => 'tested@popravi.mk', :password => 'invalid'

      json = JSON.parse(response.body)

      json['status'].should == "error"
      json['message'].should == "Невалиден email или лозинка"
    end

    it "can login when correct email and password" do
      municipality = Factory.create(:municipality)
      user = Factory.create(:user, :email => 'tested@popravi.mk',
                                   :password => 'password',
                                   :municipality => municipality)

      post :create, :format => 'json', :api_key => @api_key.key,
           :email => 'tested@popravi.mk', :password => 'password'

      json = JSON.parse(response.body)

      json['status'].should == "ok"
      json['municipality_id'].should == municipality.id
    end
  end
end
