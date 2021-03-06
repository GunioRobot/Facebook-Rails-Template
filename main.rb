# rails new test_app -m facebook-template/main.rb
path = "#{File.dirname(__FILE__)}"

apply path + "/template_cleanup.rb"
apply path + "/template_configs.rb"
apply path + "/template_s3.rb"
apply path + "/template_controllers.rb"
apply path + "/template_helpers.rb"
apply path + "/template_stylesheets.rb"
apply path + "/template_javascripts.rb"
apply path + "/template_layout.rb"
apply path + "/template_gems.rb"
apply path + "/template_git.rb"