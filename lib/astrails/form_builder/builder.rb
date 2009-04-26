require "haml"

module Astrails
  module FormBuilder

    class Builder < ActionView::Helpers::FormBuilder
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::TextHelper
      include Haml::Helpers

      @@field_keys = [:label, :label_html, :label_class]

      %w/text_field text_area password_field file_field date_select time_select country_select/.each do |name|
        class_eval <<-END, __FILE__, __LINE__
          def #{name}(method, options = {}, html_options = {})
            clean_field do
              @template.content_tag(:div, 
                label_with_error(method, options) + 
                super(method, options.except(*@@field_keys).merge(:class => :text)) +
                error_html(method), surround_opts(method))
            end
          end
        END
      end

    %w/check_box/.each do |name|
      class_eval <<-END, __FILE__, __LINE__
        def #{name}(method, options = {}, html_options = {})
          clean_field do
            @template.content_tag(:div, 
              super(method, options.except(*@@field_keys).merge(:class => :checkbox)) +
              label_with_error(method, options.merge(:label_class => "sameline")) + 
              error_html(method), surround_opts(method))
          end
        end
      END
    end

    def surround_opts(method)
      return {} unless has_errors?(method)
      {:class => "error"}
    end

    def label_with_error(method, options)
      content = options.delete(:label) || options.delete(:label_html) || method.to_s.humanize
      options[:class] = options.delete(:label_class) || nil

      options[:for] ||= @object_name ? "#{@object_name}_#{method}" : method
                 @template.content_tag :label, content, options.merge(:id => "label_#{options[:for]}")
      end

      def error_html(method)
        has_errors?(method) && @template.content_tag(:em, merge_errors(method)) || ""
      end

      def clean_field
        # reset default "fieldWithErrors" wrapper
        field_error_proc, ActionView::Base.field_error_proc = ActionView::Base.field_error_proc, Proc.new{ |html_tag, instance| html_tag}
        yield
      ensure
        # revert default "fieldWithErrors" wrapper
        ActionView::Base.field_error_proc = field_error_proc if field_error_proc
      end  

      def merge_errors(method)
        errors = has_errors?(method)
        errors = [errors] unless errors.is_a?(Array)
        errors.join(", ")
      end

      def has_errors?(method)
        return false unless @object.respond_to?(:errors) 
        return @object.errors.on(method) if @object.errors.on(method)
        return has_errors?("base") if :uploaded_data == method
        false
      end

    end
  end
end
