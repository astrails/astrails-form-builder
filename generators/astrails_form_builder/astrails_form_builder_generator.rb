require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
require File.expand_path(File.dirname(__FILE__) + "/lib/rake_commands.rb")

class AstrailsFormBuilderGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file("stylesheets/astrails_form_builder.css", "public/stylesheets/astrails_form_builder.css")
      m.insert_into "app/views/layouts/application.html.haml", "  != stylesheet_link_tag 'astrails_form_builder', :cache => 'main'"
    end
  end
end
