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

        return "#{source_name} - Corifeu" if message_down['av. corifeu de azevedo']
        return "#{source_name} - Braz Leme" if message_down['av. braz leme']
        return "#{source_name} - Autonomistas" if message_down['av. dos autonomistas']
        return "#{source_name} - Otto Baumgart" if message_down['av. otto baumgart']

        source_name
      end
    end
  end
end
