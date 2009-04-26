require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
require File.expand_path(File.dirname(__FILE__) + "/lib/rake_commands.rb")

class AstrailsFormBuilderGenerator < Rails::Generator::Base
  def manifest
    record do |m|

      # CSS
      m.file("public/stylesheets/astrails_form_builder.css", "stylesheets/astrails_form_builder.css")
      m.insert_into "app/views/layouts/application.html.haml", "    stylesheet_link_tag 'astrails_form_builder', :cache => 'main'"

      # HELPER
      m.insert_into "app/helpers/application_helper.rb", "include Astrails::FormBuilder::Helper"
    end
  end
end
