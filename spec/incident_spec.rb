require 'spec_helper'

describe ServiceNow::Incident do
  describe '.find' do
    it 'finds a record by the sys id' do
      VCR.use_cassette('incident') do
        expect(ServiceNow::Incident.find('7c7cdfc1136ed6400465bd122244b0d0', host: ENV['SN_HOST'], user: ENV['SN_USER'], password: ENV['SN_PASSWORD'])['number']).to eql('INC0726249')
      end
    end
  end
end
