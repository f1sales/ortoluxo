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

  context 'when lead come from Simmons' do
    context 'when the source is Widgrid' do
      before { source.name = 'Widgrid - Simmons' }

      context 'when message contain Shopping Aricanduva' do
        before { lead.message = 'Simmons - ESC - Aricanduva - Shopping Aricanduva - Mattress One' }

        it 'returns Simmons - Facebook - Aricanduva' do
          expect(switch_source).to eq('Widgrid - Simmons - Aricanduva')
        end
      end

      context 'when message contain Teodoro Sampaio' do
        before { lead.message = 'Simmons - ESC - Pinheiros - Rua Teodoro Sampaio, 1649 - Mattress One' }

        it 'returns Simmons - Facebook - Aricanduva' do
          expect(switch_source).to eq('Widgrid - Simmons - Teodoro')
        end
      end

      context 'when message contain Shopping União' do
        before { lead.message = 'Simmons - ESC - Vila Yara - Shopping União - Mattress One' }

        it 'returns Simmons - Facebook - Aricanduva' do
          expect(switch_source).to eq('Widgrid - Simmons - Osasco')
        end
      end

      context 'when message contain Salim Farah Maluf' do
        before { lead.message = 'Simmons - ESC - Tatuape - Av. Salim Farah Maluf, 3167 - Mattress One' }

        it 'returns Simmons - Facebook - Aricanduva' do
          expect(switch_source).to eq('Widgrid - Simmons - Salim')
        end
      end

      context 'when message contain Shopping Lar Center' do
        before { lead.message = 'Simmons - ESC - Vila Guilherme - Shopping Lar Center - Mattress One' }

        it 'returns Simmons - Facebook - Lar Center' do
          expect(switch_source).to eq('Widgrid - Simmons - Lar Center')
        end
      end
    end

    context 'when the source is Facebook' do
      before { source.name = 'Simmons - Facebook' }

      context 'when message contain Shopping Aricanduva' do
        before { lead.message = 'conditional_question_2: São Paulo; conditional_question_3: Aricanduva - Shopping Aricanduva - Mattress One; conditional_question_1: São Paulo' }

        it 'returns Simmons - Facebook - Aricanduva' do
          expect(switch_source).to eq('Simmons - Facebook - Aricanduva')
        end
      end

      context 'when message contain Teodoro Sampaio' do
        before { lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Pinheiros - Rua Teodoro Sampaio, 1649 - Mattress One' }

        it 'returns Simmons - Facebook - Aricanduva' do
          expect(switch_source).to eq('Simmons - Facebook - Teodoro')
        end
      end

      context 'when message contain Shopping União' do
        before { lead.message = 'conditional_question_1: São Paulo; conditional_question_2: Osasco; conditional_question_3: Vila Yara - Shopping União - Mattress One' }

        it 'returns Simmons - Facebook - Aricanduva' do
          expect(switch_source).to eq('Simmons - Facebook - Osasco')
        end
      end

      context 'when message contain Salim Farah Maluf' do
        before { lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Tatuape - Av. Salim Farah Maluf, 3167 - Mattress One' }

        it 'returns Simmons - Facebook - Aricanduva' do
          expect(switch_source).to eq('Simmons - Facebook - Salim')
        end
      end

      context 'when message contain Shopping Lar Center' do
        before { lead.message = 'conditional_question_2: São Paulo; conditional_question_3: Vila Guilherme - Shopping Lar Center - Mattress One; conditional_question_1: São Paulo' }

        it 'returns Simmons - Facebook - Lar Center' do
          expect(switch_source).to eq('Simmons - Facebook - Lar Center')
        end
      end
    end
  end
end
