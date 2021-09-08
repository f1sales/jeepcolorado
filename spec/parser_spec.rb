require 'ostruct'
require 'byebug'
require "f1sales_custom/parser"
require "f1sales_custom/source"

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when came from the website' do
    let(:email) {
      email = OpenStruct.new
      email.to = [email: 'website@jeepcolorado.f1sales.net']
      email.subject = 'Veículo Novo Site | jeepcolorado.com.br'
      email.body = "Veículo Novo Site | jeepcolorado.com.br\n\n*Nome:*\n\nTeste Lead Site Jeep Colorado\n\n*E-mail:*\n\nteste@lead.com\n\n*Telefone:*\n\n(13)9313-13131\n\n*Mensagem:*\n\nAgora vai funcionar direitinho...\n\n*Veículo:*\n\n- Commander Limited T270 Flex\n\n*Data de envio:*\n\n31/08/2021 22:41:54"

      email
    }

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains lead website a source name' do
      expect(parsed_email[:source][:name]).to eq('Website')
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Teste Lead Site Jeep Colorado')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('13931313131')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('teste@lead.com')
    end

    it 'contains product' do
      expect(parsed_email[:product]).to eq('- Commander Limited T270 Flex')
    end

    it 'contains message' do
      expect(parsed_email[:message]).to eq('Agora vai funcionar direitinho...')
    end
  end
end
