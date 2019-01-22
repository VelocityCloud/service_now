require 'spec_helper'

describe ServiceNow::Incident do
  let(:auth) { { host: ENV['SN_HOST'], user: ENV['SN_USER'], password: ENV['SN_PASSWORD'] } }

  describe '.all' do
    it 'finds records by the params' do
      VCR.use_cassette('incidents') do
        incidents = ServiceNow::Incident.all({ sysparm_limit: 25 }, auth)['result']
        expect(incidents.size).to eql(25)
        expect(incidents[0]['number']).to eql('INC0012720')
      end
    end
  end

  describe '.find' do
    it 'finds a record by the sys id' do
      VCR.use_cassette('incident') do
        expect(ServiceNow::Incident.find('7c7cdfc1136ed6400465bd122244b0d0', auth)['result']['number']).to eql('INC0726249')
      end
    end
  end

  describe '.create' do
    it 'creates a record' do
      VCR.use_cassette('create_incident') do
        params =  { 
          active: 'false',
          category: 'network',
          description: 'User cannot access email on mail.company.com.',
          knowledge: 'false',
          made_sla: 'false',
          short_description: 'Cannot read email'
        } 
        expect(ServiceNow::Incident.create(params, auth)['result']['sys_id']).to eql('9719345913621ec0fef07d322244b058')
      end
    end

    it 'returns the hash with the error' do
      VCR.use_cassette('create_invalid_incident') do
        expect(ServiceNow::Incident.create({}, auth)['error']['detail']).to eql('Required to provide Auth information')
      end
    end
  end

  describe '.update' do
    it 'updates a record' do
      VCR.use_cassette('update_incident') do
        params =  { active: 'true' } 
        expect(ServiceNow::Incident.update('9719345913621ec0fef07d322244b058', params, auth)['result']['active']).to be_truthy
      end
    end
  end
end
