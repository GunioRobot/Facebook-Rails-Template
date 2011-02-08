file 'config/heroku.yml', <<-CODE
apps:
  production: my_app

stacks:
  all: bamboo-mri-1.9.2

config:
  all:
    BUNDLE_WITHOUT: "test:development"
    S3_ACCESS_KEY_ID: 
    S3_SECRET_ACCESS_KEY: 

collaborators:
  all:
    - "pomartel@coderubik.com"

# domains:
#   production:
#     - "awesomeapp.com"
#     - "www.awesomeapp.com"

addons:
  production:
    - cron:daily
    - exceptional:basic
    - logging:expanded
CODE