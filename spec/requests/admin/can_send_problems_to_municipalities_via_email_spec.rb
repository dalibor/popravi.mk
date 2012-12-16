require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    # problem1 is already reported
    # problem4 is in municipality that don't have user in the system
    # problem2, problem3 and problem5 should be sent
    category = create :category, name: "category1"
    municipality1 = create :municipality, name: "municipality1"
    user = create :user, email: "municipality1@popravi.mk", municipality: municipality1
    create :problem, municipality: municipality1, category: category, description: "problem1", sent_at: "2010-07-25 14:05:56"
    create :problem, municipality: municipality1, category: category, description: "problem2"
    create :problem, municipality: municipality1, category: category, description: "problem3"

    municipality2 = create :municipality, name: "municipality2"
    create :problem, municipality: municipality2, category: category, description: "problem4"

    municipality3 = create :municipality, name: "municipality3"
    create :user, email: "municipality3@popravi.mk", municipality: municipality3
    create :problem, municipality: municipality3, category: category, description: "problem5"

    login(admin)
    click_link "Admin"
    reset_mailer
  end

  it "can filter problems by sent and unsent" do
    click_link "Problems"
    page.should have_content "problem1"
    page.should have_content "problem2"
    page.should have_content "problem3"
    page.should have_content "problem4"
    page.should have_content "problem5"

    click_link "Sent"
    page.should have_content "problem1"
    page.should_not have_content "problem2"
    page.should_not have_content "problem3"
    page.should_not have_content "problem4"
    page.should_not have_content "problem5"

    click_link "Unsent"
    page.should_not have_content "problem1"
    page.should have_content "problem2"
    page.should have_content "problem3"
    page.should have_content "problem4"
    page.should have_content "problem5"
  end

  it "sends problems to municipalities via email" do
    click_link "Problems"
    click_link "Send problems to municipalities via email"
    page.should have_content "Problems were successfullly sent to municipalities"
    unread_emails_for("municipality1@popravi.mk").size.should == parse_email_count(1)
    unread_emails_for("municipality2@popravi.mk").size.should == parse_email_count(0)
    unread_emails_for("municipality3@popravi.mk").size.should == parse_email_count(1)

    open_email("municipality1@popravi.mk")
    current_email.subject.should have_content "[PopraviMK] Recently reported problems"
    current_email.body.should have_content "Hello municipality1"
    current_email.body.should have_content "Following problems has been reported to your municipality"
    current_email.body.should have_content "problem2"
    current_email.body.should have_content "problem3"

    visit_in_email "municipality1 category1"
    page.should have_content "problem2"

    open_email("municipality3@popravi.mk")
    current_email.subject.should have_content "[PopraviMK] Recently reported problems"
    current_email.body.should have_content "Hello municipality3"
    current_email.body.should have_content "Following problems has been reported to your municipality"
    current_email.body.should have_content "problem5"

    visit_in_email "municipality3 category1"
    page.should have_content "problem5"

    click_link "Admin"
    click_link "Problems"
    click_link "Sent"
    page.should have_content "problem1"
    page.should have_content "problem2"
    page.should have_content "problem3"
    page.should have_content "problem5"
    page.should_not have_content "problem4"
  end
end
