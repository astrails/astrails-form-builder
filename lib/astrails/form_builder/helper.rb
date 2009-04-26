module Astrails
  module FormBuilder
    module Helper
      def self.included(base)
        base.class_eval do
          alias_method_chain :form_for, :builder
          alias_method_chain :fields_for, :builder
          alias_method_chain :form_remote_for, :builder
          alias_method_chain :remote_form_for, :builder
        end
      end
                              
      def form_for_with_builder(object_name, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options.update(:builder => Builder)
        form_for_without_builder(object_name, *(args << options), &proc)
      end

      def fields_for_with_builder(record_or_name_or_array, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options.update(:builder => Builder)
        fields_for_without_builder(record_or_name_or_array, *(args << options), &proc)
      end

      def form_remote_for_with_builder(record_or_name_or_array, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options.update(:builder => Builder)
        form_remote_for_without_builder(record_or_name_or_array, *(args << options), &proc)
      end
      alias :remote_form_for_with_builder :form_remote_for_with_builder

    end
  end
end
