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
  $('a').each ->
    if not /^(https?:\\/\\/|#)/.test($(this).attr('href'))
      $(this).attr('href', "http://apps.facebook.com/\#{CANVAS_NAME}" + $(this).attr('href'))
      if not /^#/.test($(this).attr('href'))
        $(this).attr('target', '_top') unless $(this).attr('target')
CODE