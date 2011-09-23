app_config = <<-GENERATORS
  config.generators do |g|
      g.template_engine :haml
      g.test_framework  false
    end
    
    config.time_zone = 'Eastern Time (US & Canada)'
    
    config.autoload_paths << File.join(config.root, "lib")
GENERATORS
application app_config

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

initializer 'facebooker2.rb', <<-CODE
Facebooker2.load_facebooker_yaml
CODE

file 'config/settings.yml', <<-CODE
defaults: &defaults
  admin_uids:
    - 594760378
    
development:
  <<: *defaults
  
production:
  <<: *defaults
CODE

file 'lib/settings.rb', <<-CODE
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