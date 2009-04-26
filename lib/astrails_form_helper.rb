module ActionView
  module Helpers #:nodoc:
    module AstrailsFormHelper
      def astrails_form_for(object_name, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options.update(:builder => AstrailsFormBuilder)
        form_for(object_name, *(args << options), &proc)
      end

      def astrails_fields_for(record_or_name_or_array, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options.update(:builder => AstrailsFormBuilder)
        fields_for(record_or_name_or_array, *(args << options), &proc)
      end

      def astrails_form_remote_for(record_or_name_or_array, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options.update(:builder => AstrailsFormBuilder)
        form_remote_for(record_or_name_or_array, *(args << options), &proc)
      end  
    end
  end
end
