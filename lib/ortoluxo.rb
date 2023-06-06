# frozen_string_literal: true

require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'
require_relative 'ortoluxo/version'

module Ortoluxo
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      def switch_source(lead)
        @lead = lead
        return "#{source_name} - Corifeu" if message['av. corifeu de azevedo']
        return "#{source_name} - Braz Leme" if message['av. braz leme']
        return "#{source_name} - Autonomistas" if message['av. dos autonomistas']
        return "#{source_name} - Otto Baumgart" if message['av. otto baumgart']
        return "#{source_name} - Teodoro" if message['teodoro sampaio']
        return "#{source_name} - Salim" if message['av. salim farah maluf']
        return "#{source_name} - Aricanduva" if message['aricanduva']
        return "#{source_name} - Osasco" if message['shopping união'] || product_name['osasco']
        return "#{source_name} - Lar Center" if message['lar center'] || product_name['lar center']
        return "#{source_name} - Belenzinho" if message['belenzinho']
        return "#{source_name} - Interlagos" if message['interlagos']

        source_name
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
