# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'
require 'paperclip/matchers'

# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/factories/'
  config.include Paperclip::Shoulda::Matchers

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses its own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  #
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner

  # Devise
  require "devise/test_helpers"
  class ActionController::TestCase
    include Devise::TestHelpers
  end

  def create_admin_user_and_sign_in
    user = Factory.create(:user, :email => "admin@popravi.mk", :role => 'admin')
    user.save(:validate => true)
    user.confirm!
    sign_in user
  end
end

# Finds all setter methods for the object,
# builds a new object with these methods set to an arbitrary value,
# checks if the given attrs are able to be mass assigned and all others are not,
# and finally returns true if there are no failures.
Spec::Matchers.define :only_mass_assign_accessible_attributes do |*attrs|
  match do |object|
    setters = object.methods.map{|m| m if m.match(/[a-z].*\=$/)}.compact
    getters = setters.map{|s| s.gsub('=', '').to_sym}

    params = {}
    getters.each do |getter|
      params[getter] = 'test'
    end
    record = object.class.new(params)

    @shouldnt, @should = [], []
    getters.each do |getter|
      value = record.send(getter)
      if value == 'test' && !attrs.include?(getter)
        @shouldnt << getter.to_s
      elsif value != 'test' && attrs.include?(getter)
        @should << getter.to_s
      end
    end

    @shouldnt.length > 0 && @should.length > 0 ? false : true
  end

  failure_message_for_should do |actual|
    str = ""
    str += "The following attributes were mass assigned even though they shouldn't have been: #{@shouldnt.to_yaml}" unless @shouldnt.empty?
    str += "The following attributes were not mass assigned even though they should have been: #{@should.to_yaml}" unless @should.empty?
    str
  end
end
