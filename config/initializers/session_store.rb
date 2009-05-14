# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_railsjquery_session',
  :secret      => '19357ed8ca58d37fe9aba07ed91b64c9a73b3e0a503106a4ac9596dc2ae2811cdac2eff8b851d647e9ca75f2754ef2142c340e837eb77af4ad6f3cde57c8532b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
