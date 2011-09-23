file '.rvmrc', <<-CODE
rvm --create use  "ruby-1.9.2@rails31"
CODE

run 'rm .gitignore'

file '.gitignore', <<-FILE
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
gems/*
!gems/cache
!gems/bundler
public/assets
.sass-cache/
FILE

git :init
git :add => '.'
git :commit => "-a -m 'Initial commit'"