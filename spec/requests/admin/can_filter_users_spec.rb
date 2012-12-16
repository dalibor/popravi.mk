require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
    municipality = create(:municipality, name: "municipality")
    create(:user, email: "moderator@popravi.mk", municipality: municipality)
    create(:user, email: "reporter@popravi.mk")
  end

  it 'can filter users by role' do
    click_link "Admin"
    click_link "Users"
    page.should have_content "admin@popravi.mk"
    page.should have_content "moderator@popravi.mk"
    page.should have_content "reporter@popravi.mk"

    click_link "Admins"
    page.should have_content "admin@popravi.mk"
    page.should_not have_content "moderator@popravi.mk"
    page.should_not have_content "reporter@popravi.mk"

    click_link "Moderators"
    page.should_not have_content "admin@popravi.mk"
    page.should have_content "moderator@popravi.mk"
    page.should_not have_content "reporter@popravi.mk"

    click_link "Reporters"
    page.should_not have_content "admin@popravi.mk"
    page.should_not have_content "moderator@popravi.mk"
    page.should have_content "reporter@popravi.mk"
  end
end
