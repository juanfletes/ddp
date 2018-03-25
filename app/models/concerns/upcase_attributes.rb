# encoding: utf-8

module UpcaseAttributes
  extend ActiveSupport::Concern

  included do
    extend ClassMethods
    upcase_attributes
    include InstanceMethods
    before_validation :upcase_attributes
  end

  module ClassMethods
    def upcase_attributes(options = {})
      cattr_reader :upcase_attributes_options do
        { except: Array(options[:except] ||= []), only: Array(options[:only] ||= []) }
      end
    end
  end

  module InstanceMethods
    def upcase_attributes
      return if ENV['RAILS_ENV'].eql?('test')
      return if upcase_attributes_options.nil?
      self.class.columns.each do |column|
        next unless column.type == :string || column.type == :text
        field = column.name.to_sym
        value = self[field]
        next unless value.respond_to?(:upcase) && !upcase_attributes_options[:except].include?(field)
        next if upcase_attributes_options[:only].any? && !upcase_attributes_options[:only].include?(field)
        self[field] = value.blank? ? nil : value.mb_chars.upcase.to_s
      end
    end
  end
end
