initializer 'barista.rb', <<-CODE
if Rails.env.development?
  Barista.configure do |c|
    c.output_root = Rails.root.join("public", "javascripts", "compiled")
    c.bare!
  end
end
CODE

file 'app/coffeescripts/facebook.coffee', <<-CODE
$ ->
  initialize_form_style()
  
  $('a[data-ajax!="true"]').each ->
    if not /^(https?:\/\/|#)/.test($(this).attr('href'))
      $(this).attr('href', "http://apps.facebook.com/#{CANVAS_NAME}" + $(this).attr('href'))
    if not /^#/.test($(this).attr('href'))
      $(this).attr('target', '_top') unless $(this).attr('target')
  
  $('a[data-popup], .fb_link').live 'click', (e) ->
    window.open(this.href, 'preview', 'status=0,toolbar=0,menubar=0,scrollbars=1,width=1000,height=800')
    e.preventDefault()
CODE