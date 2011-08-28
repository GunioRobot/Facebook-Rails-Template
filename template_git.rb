file '.rvmrc', <<-CODE
rvm --create use  "ruby-1.9.2@rails3"
CODE

run 'rm .gitignore'

file '.gitignore', <<-FILE
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
public/uploads/*
gems/*
!gems/cache
!gems/bundler
FILE

git :init
git :add => '.'
git :commit => "-a -m 'Initial commit'"