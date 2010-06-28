# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_popravi_session',
  :secret      => '232a0529873ba52262573fb7264000ff8900b146b3949308cd6be70e150d8ff351e2d805119919b2172a55ae579de1f90366b5b0266697bb4bd16c4a1324ef02'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
