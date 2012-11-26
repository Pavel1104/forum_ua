# -*- coding: utf-8 -*-

module WithRailsLogger
  def _debug(*args)
    Rails.logger.debug "!!!!!"
    args.each do |arg|
      Rails.logger.debug "!!!!!" + arg.inspect
    end
    Rails.logger.debug "!!!!!"
  end
end

Object.send :include, WithRailsLogger

module ActionView::Helpers
  module FormHelper
    def caption(class_name, attribute, required = false)
      text = attribute.is_a?(Symbol) ? class_name.human_attribute_name(attribute) : attribute
      required ? "#{text}<span class=\"required\">*</span>".html_safe : text
    end
  end

  class FormBuilder
    def caption(attribute, required = false)
      text = attribute.is_a?(Symbol) ? @object.class.human_attribute_name(attribute) : attribute
      required ? "#{text}<span class=\"required\">*</span>".html_safe : text
    end
  end
end

class Hash
  def recursively_symbolize_keys!
    self.symbolize_keys! if self.respond_to?(:symbolize_keys!)
    self.values.each do |v|
      if v.is_a?(Hash)
        v.recursively_symbolize_keys!
      elsif v.is_a?(Array)
        v.recursively_symbolize_keys!
      end
    end
    self
  end
end

class Array
  def recursively_symbolize_keys!
    self.each do |v|
      if v.is_a?(Hash)
        v.recursively_symbolize_keys!
      elsif v.is_a?(Array)
        v.recursively_symbolize_keys!
      end
    end
  end
end
