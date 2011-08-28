run 'rm app/helpers/application_helper.rb'
file 'app/helpers/application_helper.rb', <<-CODE
module ApplicationHelper

  def body_id
    "\#{params[:controller].gsub('/', '_')}_\#{params[:action]}"
  end
  
  def body_class
    [params[:action], I18n.locale.to_s].split(" ")
  end
  
  def flash_messages(*types)
    types = [:alert, :notice] if types.empty?
    types.collect do |t|
      content_tag(:div, flash[t], :class => "flash \#{t.to_s}") if flash[t]
    end.join("\\n").html_safe
  end
  
end
CODE