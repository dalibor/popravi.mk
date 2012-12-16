def fake_login(user)
  session[:user_id] = user.id
end

def login(user)
  visit user_session_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
end

def report_a_problem
  visit root_path
  create :category
  create :municipality
  click_link "Report"
  fill_in "problem_description", with: "Problem description"
  attach_file "problem_photo", "public/images/rails.png"
  find("#problem_latitude").set(42)
  find("#problem_longitude").set(21)
  select "Abandoned vehicles", from: "problem_category_id"
  select "Butel", from: "problem_municipality_id"
  click_button "Report a problem"
  page.should have_content "Problem was successfully reported"
end
