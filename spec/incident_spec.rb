require 'spec_helper'

describe ServiceNow::Incident do
  let(:auth) { { host: ENV['SN_HOST'], user: ENV['SN_USER'], password: ENV['SN_PASSWORD'] } }

  describe '.find' do
    it 'finds a record by the sys id' do
      VCR.use_cassette('incident') do
        expect(ServiceNow::Incident.find('7c7cdfc1136ed6400465bd122244b0d0', auth)['number']).to eql('INC0726249')
      end
    end
  end

  describe '.create' do
    it 'creates a record' do
      VCR.use_cassette('create_incident') do
        params =  { 
          :active => 'false',
          :category => 'network',
          :description => 'User cannot access email on mail.company.com.',
          :knowledge => 'false',
          :made_sla => 'false',
          :short_description => 'Cannot read email'
        } 
        expect(ServiceNow::Incident.create(params, auth)['sys_id']).to eql('9719345913621ec0fef07d322244b058')
      end
    end
  end
end
