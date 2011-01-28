run 'rm app/views/layouts/application.html.erb'

file 'app/views/layouts/application.html.haml', <<-CODE
!!!
%html
  %head
    = javascript_include_tag 'jquery.js', 'compiled/facebook.js'
    = stylesheet_link_tag 'compiled/reset.css', 'compiled/common.css', 'compiled/facebook.css' :media => 'all'
    = csrf_meta_tag

    %title Facebook App
      
    :javascript
      CANVAS_NAME = "\#{Settings.canvas_name}"
    
  %body{ :id => body_id }
    = render 'shared/fb_libs'
    #main      
      = yield

      #footer
CODE

file 'app/views/layouts/tab.html.haml', <<-CODE
%style= output_css_file_content('compiled/tab.css')
%script= output_js_file_content('compiled/tab.js')

#tab= yield
CODE


file 'app/views/shared/_error_messages.html.haml', <<-CODE
- if target.errors.any?  
  #errorExplanation
    %ul
      - target.errors.full_messages.each do |msg|
        %li= msg
CODE

file 'app/views/shared/_fb_libs.html.haml', <<-CODE
= raw fb_connect_async_js(Facebooker2.app_id, :language => 'fr_FR', :extra_js => 'FB.Canvas.setAutoResize();')
CODE