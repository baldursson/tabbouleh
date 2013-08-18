module Tabbouleh
  module ActionView
    module Tags
      module ParsleyValidation

        def self.prepended(base)

          base.class_eval do

            def data_attributes
              @data_attributes ||= {}
            end

            def render_with_parsley
              object._validators[@method_name.to_sym].each do |validator|

                options = validator.options.deep_dup

                case validator
                when ::ActiveRecord::Validations::PresenceValidator,
                     ::ActiveModel::Validations::AcceptanceValidator
                  add_parsley_validation :required, true, :blank, options

                when ::ActiveModel::Validations::FormatValidator
                  add_parsley_validation :regexp, options[:with].to_javascript, :invalid, options

                when ::ActiveModel::Validations::LengthValidator
                  add_parsley_length_validation :minlength, :minimum, :too_short, options
                  add_parsley_length_validation :maxlength, :maximum, :too_long, options
                  add_parsley_length_validation :rangelength, :is, :wrong_length, options

                when ::ActiveModel::Validations::NumericalityValidator
                  if options[:only_integer]
                    add_parsley_validation :type, :digits, :not_an_integer, options
                  else
                    add_parsley_validation :type, :number, :not_a_number, options
                  end

                  add_parsley_length_validation :min, :greater_than, :greater_than, options, -> (v) { v.to_i + 1 }
                  add_parsley_length_validation :min, :greater_than_or_equal_to, :greater_than_or_equal_to, options
                  add_parsley_length_validation :max, :less_than, :less_than, options, -> (v) { v.to_i - 1 }
                  add_parsley_length_validation :max, :less_than_or_equal_to, :less_than_or_equal_to, options

                end
              end

              if @method_name.end_with? '_confirmation'
                confirmable_name = @method_name.sub(/_confirmation$/, '')
                confirmation_validator = object._validators[confirmable_name.to_sym].select do |v|
                  v.instance_of? ::ActiveModel::Validations::ConfirmationValidator
                end

                if confirmation_validator.present?
                  options = confirmation_validator.first.options.deep_dup
                  options[:attribute] = object.class.human_attribute_name(confirmable_name)
                  add_parsley_validation :equalto, ['#', tag_id.sub(/_confirmation$/, '')].join, :confirmation, options
                end
              end

              html_options = @html_options || @options
              html_options.deep_merge!(data: data_attributes)
              
              render_without_parsley
            end

            alias_method_chain :render, :parsley

            private

            def add_parsley_validation(constraint, value, message_type, options)
              data_attributes[constraint] = value
              data_attributes["#{constraint}-message".to_sym] = object.errors.generate_full_message(@method_name, message_type, options)
            end

            def add_parsley_validation_from_option(constraint, value_name, message_type, options, value_modifier = nil)
              value = options[value_name]
              unless value.blank?
                value = value_modifier.call(value) unless value_modifier.nil?
                add_parsley_validation constraint, value, message_type, options
              end
            end

            def add_parsley_length_validation(constraint, value_name, message_type, options, value_modifier = nil)
              add_parsley_validation_from_option constraint, value_name, message_type, options.merge(count: options[value_name]), value_modifier
            end

          end

        end
      end
    end
  end
end