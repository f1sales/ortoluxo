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
        source_name = lead.source.name
        message_down = lead.message&.downcase || ''
        product_name_down = lead.product.name&.downcase || ''

        return "#{source_name} - Corifeu" if message_down['av. corifeu de azevedo']
        return "#{source_name} - Braz Leme" if message_down['av. braz leme']
        return "#{source_name} - Autonomistas" if message_down['av. dos autonomistas']
        return "#{source_name} - Otto Baumgart" if message_down['av. otto baumgart']
        return "#{source_name} - Teodoro" if message_down['teodoro sampaio']
        return "#{source_name} - Salim" if message_down['av. salim farah maluf']
        return "#{source_name} - Aricanduva" if message_down['aricanduva']
        return "#{source_name} - Osasco" if message_down['shopping união']
        return "#{source_name} - Lar Center" if message_down['lar center'] || product_name_down['lar center']
        return "#{source_name} - Belenzinho" if message_down['belenzinho']
        return "#{source_name} - Interlagos" if message_down['interlagos']
        return "#{source_name} - Osasco" if product_name_down['osasco']

        source_name
      end
    end
  end
end
