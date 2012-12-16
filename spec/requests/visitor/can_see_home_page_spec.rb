require 'spec_helper'

describe "Visitor" do
  it "can see landing page" do
    visit root_path
    page.should have_content "Improve your city"
  end
end
