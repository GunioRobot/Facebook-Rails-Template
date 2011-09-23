run 'rm app/assets/javascripts/application.js'
file 'app/assets/javascripts/application.js', <<-CODE
//= require jquery
//= require jquery_ujs
//= require facebook
CODE

file 'app/assets/javascripts/facebook.js.coffee', <<-CODE
$ ->
  # Focus on the first text field
  $('.initial-focus:first').focus()
CODE