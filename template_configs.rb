app_config = <<-GENERATORS
  config.generators do |g|
      g.template_engine :haml
      g.test_framework  false
    end
    
    config.time_zone = 'Eastern Time (US & Canada)'
    
    config.autoload_paths << File.join(config.root, "lib")
GENERATORS
application app_config

run 'rm script/rails'
file 'script/rails', <<-CODE
#!/usr/bin/env ruby
# This command will automatically be run when you run "rails" with Rails 3 gems installed from the root of your application.

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)

# THIS IS NEW:
require "rails/commands/server"
module Rails
  class Server
    def default_options
      super.merge({
        :Port        => 10524,
        :environment => (ENV['RAILS_ENV'] || "development").dup,
        :daemonize   => false,
        :debugger    => false,
        :pid         => File.expand_path("tmp/pids/server.pid"),
        :config      => File.expand_path("config.ru")
      })
    end
  end
end
# END OF CHANGE

require 'rails/commands'
CODE

file 'config/database.yml', <<-CODE
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000
CODE

file 'config/facebooker.yml', <<-CODE
development:
  app_id:  
  api_key: 
  secret:  

production:
  app_id:  
  api_key: 
  secret:  
CODE

file 'config/initializers/facebooker2.rb', <<-CODE
Facebooker2.load_facebooker_yaml
CODE

file 'config/settings.yml', <<-CODE
defaults: &defaults
  facebook_apps_url: http://apps.facebook.com
  canvas_name: my_app
  admin_uids:
    - 594760378
    
development:
  <<: *defaults
  
production:
  <<: *defaults
CODE

file 'app/models/settings.rb', <<-CODE
class Settings < Settingslogic
   source "\#{Rails.root}/config/settings.yml"
   namespace Rails.env
 end
CODE

inside "config/locales" do
file 'fr.yml', <<-CODE
fr:
  hello: "Bonjour"
CODE
get "https://github.com/svenfuchs/rails-i18n/raw/master/rails/locale/fr.yml", "fr-defaults.yml"
end