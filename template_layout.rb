file 'app/views/layouts/application.html.haml', <<-CODE
!!!
%html
  %head
    = title_tag "optional default title here", :prefix => "optional prefix text", :suffix => "optional suffix text" 
    = description_tag "optional default meta description here"
    = keywords_tag "optional default meta keywords here"
    = copyright_tag "optional default meta copyright notice here"
    = stylesheet_link_tag 'screen.css', :media => 'screen, projection'
    = stylesheet_link_tag 'print.css', :media => 'print'
    = stylesheet_link_tag 'ie.css', :media => 'screen, projection'
    = javascript_include_tag #{js_framework}
  - body do
    #wrap
      #header
        #logo Logo
      %ul#nav
        %li= link_to "Home", root_url
      #page
        = yield
CODE