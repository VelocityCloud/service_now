require 'spec_helper'

describe ServiceNow::CmdbCiServer do
  let(:auth) { { host: ENV['SN_HOST'], user: ENV['SN_USER'], password: ENV['SN_PASSWORD'] } }

  describe '.destroy' do
    it 'destroys a record' do
      VCR.use_cassette('cmdb_ci_server') do
        ServiceNow::CmdbCiServer.destroy('88120727db1900d013f5c4430596197a', auth)
        response = ServiceNow::CmdbCiServer.find('88120727db1900d013f5c4430596197a', auth).parsed_response
        expect(response['error']['message']).to eql('No Record found')
      end
    end
  end
end
