require 'dropbox_sdk'
Dropbox::API::Config.app_key    = 'c2yvrtr0fmdmsyy' #YOUR_APP_KEY
Dropbox::API::Config.app_secret = '0ylbnokzyg6fdxf' #YOUR_APP_SECRET
# Dropbox::API::Config.mode       = "sandbox" # if you have a single-directory app
#Dropbox::API::Config.mode       = "dropbox" # if your app has access to the whole dropbox
DROPBOX_APP_MODE = :auto
