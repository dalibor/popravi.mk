require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  it "can see problem status transitions" do
    municipality = create :municipality, name: "municipality1"
    user = create :user, municipality: municipality, email: "moderator@popravi.mk",
      password: "password", confirmed_at: "2010-07-25 14:05:56", name: "Moderator"
    create :problem, municipality: municipality, description: "problem1"
    login(user)

    click_link "Admin"
    click_link "Problems"
    click_link "Edit"
    select "approved", from: "Status"
    click_button "Save"
    click_link "Edit"
    select "activated", from: "Status"
    click_button "Save"
    click_link "Edit"
    select "solved", from: "Status"
    click_button "Save"
    click_link "Logout"

    login(admin)
    click_link "Admin"
    click_link "Problems"
    click_link "Show"
    page.should have_content "Problem status transitions"

    page.find("table tr[2] td[1]").text.should == '1'
    page.find("table tr[2] td[2]").text.should == ''
    page.find("table tr[2] td[3]").text.should == 'reported'
    page.find("table tr[2] td[4]").text.should == 'Test User'

    page.find("table tr[3] td[1]").text.should == '2'
    page.find("table tr[3] td[2]").text.should == 'reported'
    page.find("table tr[3] td[3]").text.should == 'approved'
    page.find("table tr[3] td[4]").text.should == 'Moderator'

    page.find("table tr[4] td[1]").text.should == '3'
    page.find("table tr[4] td[2]").text.should == 'approved'
    page.find("table tr[4] td[3]").text.should == 'activated'
    page.find("table tr[4] td[4]").text.should == 'Moderator'

    page.find("table tr[5] td[1]").text.should == '4'
    page.find("table tr[5] td[2]").text.should == 'activated'
    page.find("table tr[5] td[3]").text.should == 'solved'
    page.find("table tr[5] td[4]").text.should == 'Moderator'
  end
end
