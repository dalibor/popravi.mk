module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name


    when /the home\s?page/
      root_path
    when /the\s(redisplayed)?\s*sign\s?in page/
      new_user_session_path
    when /the sign\s?up page/
      new_user_registration_path
    when /the redisplayed sign\s?up page/
      user_registration_path
    when /the edit user page/
      edit_user_registration_path
    when /the redisplayed edit user page/
      user_registration_path
    when /the resend confirmation instructions page/
      user_confirmation_path
    when /the send password instructions page/
      new_user_password_path       
    when /the send unlock instructions page/
      new_user_unlock_path
    when /the admin page/
      admin_root_path
    when /the problems page/
      problems_path
    when /the my problems page/
      my_problems_path
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
