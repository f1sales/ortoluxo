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
        return "#{source_name} - Corifeu" if corifeu?
        return "#{source_name} - Braz Leme" if braz_leme?
        return "#{source_name} - Autonomistas" if autonomistas?
        return "#{source_name} - Otto Baumgart" if otto_baumgart?
        return "#{source_name} - Teodoro" if teodoro?
        return "#{source_name} - Salim" if salim?
        return "#{source_name} - Aricanduva" if aricanduva?
        return "#{source_name} - Osasco" if osasco?
        return "#{source_name} - Lar Center" if lar_center?
        return "#{source_name} - Belenzinho" if belenzinho?
        return "#{source_name} - Interlagos" if interlagos?

        source_name
      end

      private

      def message
        @lead.message&.downcase || ''
      end

      def product_name
        @lead.product.name&.downcase || ''
      end

      def source_name
        @lead.source.name
      end

      def corifeu?
        message['av. corifeu de azevedo'] || product_name['corifeu']
      end

      def braz_leme?
        message['av. braz leme']
      end

      def autonomistas?
        message['av. dos autonomistas']
      end

      def otto_baumgart?
        message['av. otto baumgart']
      end

      def teodoro?
        message['teodoro sampaio'] || product_name['teodoro']
      end

      def salim?
        message['salim farah maluf'] || product_name['salim farah maluf']
      end

      def aricanduva?
        message['aricanduva'] || product_name['aricanduva']
      end

      def osasco?
        message['shopping união'] || product_name['osasco']
      end

      def lar_center?
        message['lar center'] || product_name['lar center']
      end

      def belenzinho?
        message['belenzinho']
      end

      def interlagos?
        message['interlagos']
      end
    end
  end
end
