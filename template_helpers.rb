run 'rm app/helpers/application_helper.rb'
file 'app/helpers/application_helper.rb', <<-CODE
module ApplicationHelper

  def body_id
    "\#{params[:controller].gsub('/', '_')}_\#{params[:action]}"
  end
  
  def flash_messages(*types)
    types = [:alert, :notice] if types.empty?
    types.collect do |t|
      content_tag(:div, flash[t], :class => "flash \#{t.to_s}") if flash[t]
    end.join("\\n").html_safe
  end
  
  def output_js_file_content(*files)
    output = files.collect { |f| IO.read(File.join(Rails.root, 'public', 'javascripts', f)) }
    output.join("\\n")
  end
  
  def output_css_file_content(*files)
    output = files.collect { |f| IO.read(File.join(Rails.root, 'public', 'stylesheets', f)) }
    output.join("\\n")
  end
  
  def fb_image_tag(src, opts = {})
    image_tag("\#{root_url}images/\#{src}", opts)
  end
  
end
CODE