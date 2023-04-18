require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Hooks::Lead do
  let(:lead) do
    lead = OpenStruct.new
    lead.message = nil
    lead.source = source

    lead
  end

  let(:source) do
    source = OpenStruct.new
    source.name = 'Some source'

    source
  end

  let(:switch_source) { described_class.switch_source(lead) }

  context 'when is a source without filter' do
    it 'return Some source' do
      expect(switch_source).to eq('Some source')
    end
  end

  context 'when lead come from Facebook' do
    context 'when lead come from King koil Prime Store' do
      before { source.name = 'Facebook - King koil Prime Store' }

      context 'when lead come with Av. Corifeu de Azevedo Marques, 593 - Butantã in message' do
        before { lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Av. Corifeu de Azevedo Marques, 593 - Butantã' }

        it 'returns Facebook - King koil Prime Store - Corifeu' do
          expect(switch_source).to eq('Facebook - King koil Prime Store - Corifeu')
        end
      end

      context 'when lead come with Av. Braz Leme, 1603 - Santana in message' do
        before { lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Av. Braz Leme, 1603 - Santana' }

        it 'returns Facebook - King koil Prime Store - Braz Leme' do
          expect(switch_source).to eq('Facebook - King koil Prime Store - Braz Leme')
        end
      end
    end

    context 'when lead come from Simmons Prime Store' do
      before { source.name = 'Facebook - Simmons Prime Store' }

      context 'when lead come with Shopping União Osasco - Av. dos Autonomistas, 1400 - Loja 1400 - Vila Yara in message' do
        before { lead.message = 'conditional_question_1: São Paulo; conditional_question_2: Osasco; conditional_question_3: Shopping União Osasco - Av. dos Autonomistas, 1400 - Loja 1400 - Vila Yara' }

        it 'returns Facebook - Simmons Prime Store - Corifeu' do
          expect(switch_source).to eq('Facebook - Simmons Prime Store - Autonomistas')
        end
      end

      context 'when lead come with Shopping Lar Center - Av. Otto Baumgart, 500 - Loja 108, Piso 1 - Vila Guilherme in message' do
        before { lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Shopping Lar Center - Av. Otto Baumgart, 500 - Loja 108, Piso 1 - Vila Guilherme' }

        it 'returns Facebook - Simmons Prime Store - Otto Baumgart' do
          expect(switch_source).to eq('Facebook - Simmons Prime Store - Otto Baumgart')
        end
      end

      context 'when lead come with R. Teodoro Sampaio, 1.649 - Pinheiro in message' do
        before { lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: R. Teodoro Sampaio, 1.649 - Pinheiros' }

        it 'returns Facebook - Simmons Prime Store - Teodoro' do
          expect(switch_source).to eq('Facebook - Simmons Prime Store - Teodoro')
        end
      end

      context 'when lead come with Av. Salim Farah Maluf, 3167 - Água Rasa in message' do
        before { lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Av. Salim Farah Maluf, 3167 - Água Rasa' }

        it 'returns Facebook - Simmons Prime Store - Salim' do
          expect(switch_source).to eq('Facebook - Simmons Prime Store - Salim')
        end
      end
    end
  end
end
