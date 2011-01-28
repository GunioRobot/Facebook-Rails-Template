file '.rvmrc', <<-CODE
if [[ -s "/Users/po/.rvm/environments/ruby-1.9.2-head@rails3" ]] ; then
  . "/Users/po/.rvm/environments/ruby-1.9.2-head@rails3"
else
  rvm --create use  "ruby-1.9.2-head@rails3"
fi
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