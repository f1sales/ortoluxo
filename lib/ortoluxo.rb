# frozen_string_literal: true

require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'
require_relative 'ortoluxo/version'

module Ortoluxo
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      SOURCE_PATTERNS = {
        'Corifeu' => ['corifeu'],
        'Braz Leme' => ['braz leme'],
        'Autonomistas' => ['autonomistas'],
        'Otto Baumgart' => ['otto baumgart'],
        'Teodoro' => ['teodoro'],
        'Salim' => ['salim'],
        'Aricanduva' => ['aricanduva'],
        'Osasco' => ['osasco', 'shopping união'],
        'Lar Center' => ['lar center'],
        'Belenzinho' => ['belenzinho'],
        'Interlagos' => ['interlagos']
      }.freeze

      def switch_source(lead)
        @lead = lead

        detected_source = detect_source
        detected_source ? "#{source_name} - #{detect_source}" : source_name
      end

      private

      def detect_source
        SOURCE_PATTERNS.each do |source_name, patterns|
          return source_name if patterns.any? { |pattern| message[pattern] || product_name[pattern] }
        end
        nil
      end

      def message
        @lead.message&.downcase || ''
      end

      def product_name
        @lead.product.name&.downcase || ''
      end

      def source_name
        @lead.source.name
      end
    end
  end
end
