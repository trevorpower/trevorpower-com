# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_trevorpower.com_session',
  :secret      => 'e2985e5824320d698b7048bc1fe7c433c1ea18a61f85483e4845043ea85ab289dfc81748470e6d1ee21161fe00945ea3f4c0197da02e5915adacdd843db6df29'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
