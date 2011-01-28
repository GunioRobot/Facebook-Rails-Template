file 'config/heroku.yml', <<-CODE
apps:
  production: my_app

stacks:
  all: bamboo-mri-1.9.2

config:
  all:
    BUNDLE_WITHOUT: "test:development"

# collaborators:
#   all:
#     - "heroku1@somedomain.com"

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