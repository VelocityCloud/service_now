
require 'spec_helper'

describe ServiceNow::Identify do
  let(:auth) { { host: ENV['SN_HOST'], user: ENV['SN_USER'], password: ENV['SN_PASSWORD'] } }

  describe '.reconcile_enhanced' do
    it 'creates a record' do
      VCR.use_cassette('reconcile_enhanced') do
        body = {
          items: [
            className: 'cmdb_ci_server',
            values: { 
              hostname: 'test123',
              active: 'false',
              category: 'network',
              description: 'User cannot access email on mail.company.com.',
              knowledge: 'false',
              made_sla: 'false',
              short_description: 'Cannot read email'
            }
          ]
        }
        query = { sysparm_data_source: 'VCamp' }
        response = ServiceNow::Identify.reconcile_enhanced(query, body, auth)
        expect(response.dig('result', 'items')[0]['operation']).to eql('INSERT_AS_INCOMPLETE')
      end
    end
  end
end
