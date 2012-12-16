require 'spec_helper'

describe "Moderator" do
  let(:municipality) { create(:municipality, name: "municipality1") }
  let(:moderator) { create(:user, municipality: municipality, email: 'moderator@popravi.mk') }

  before :each do
    login(moderator)
  end

  it "can edit contact details" do
    click_link "Admin"
    click_link "Contact"
    fill_in "About", with: "About muniicpality1"
    fill_in "Address", with: "My address"
    fill_in "Phone", with: "My phone"
    fill_in "Web", with: "My web"
    fill_in "E-mail", with: "municipality@popravi.mk"
    click_button "Save"
    page.should have_content "Contact details were successfully saved."
    find_field("About").should have_content "About muniicpality1"
    fill_in "About", with: "About muniicpality2"
    click_button "Save"
    page.should have_content "Contact details were successfully saved."
    find_field("About").should have_content "About muniicpality2"
  end
end
