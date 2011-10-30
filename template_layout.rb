run 'rm app/views/layouts/application.html.erb'

file 'app/views/layouts/application.html.haml', <<-CODE
!!!
%html
  %head
    = javascript_include_tag 'application'
    = stylesheet_link_tag 'application', :media => 'all'
    = csrf_meta_tag

    %title Facebook App

  %body{ :id => body_id, :class => body_class }
    = render 'shared/fb_libs'
    #main
      = yield

    #footer
CODE

file 'app/views/shared/_error_messages.html.haml', <<-CODE
- if target.errors.any?
  #errorExplanation
    %ul
      - target.errors.full_messages.each do |msg|
        %li= msg
CODE

file 'app/views/shared/_fb_libs.html.haml', <<-CODE
#fb-root
:javascript
  window.fbAsyncInit = function() {
    FB.init({
      appId  : '\#{Facebooker2.app_id}',
      status : true, // check login status
      cookie : true, // enable cookies to allow the server to access the session
      xfbml  : true  // parse XFBML
    });
    FB.Canvas.setAutoResize();
    $('#fb-root').trigger('fb:initialized')
  };

  (function() {
    var e = document.createElement('script'); e.async = true;
    e.src = document.location.protocol + '//connect.facebook.net/#{I18n.locale.to_s == 'fr' ? 'fr_CA' : 'en_US'}/all.js';
    $('#fb-root').append(e);
  }());
CODE