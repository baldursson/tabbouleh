require "tabbouleh/core_ext"
require "tabbouleh/active_model"
require "tabbouleh/action_view/tags/parsley_validation"

module Tabbouleh
end

tags = ActionView::Helpers::Tags.constants
tags = tags - %i(Base HiddenField Label)

tags.each do |t|
  klass = ActionView::Helpers::Tags.const_get(t)
  klass.send :prepend, Tabbouleh::ActionView::Tags::ParsleyValidation
end