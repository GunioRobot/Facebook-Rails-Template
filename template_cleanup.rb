#----------------------------------------------------------------------------
# Remove unnecessary Rails files
#----------------------------------------------------------------------------
run 'rm README'
run 'touch README'
run 'rm config/database.yml'
run 'rm public/index.html'
run 'rm app/assets/images/rails.png'

run 'rm -rf test'