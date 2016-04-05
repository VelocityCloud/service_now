require 'spec_helper'

describe ServiceNow::SysUser do
  let(:auth) { { host: ENV['SN_HOST'], user: ENV['SN_USER'], password: ENV['SN_PASSWORD'] } }

  describe '.all' do
    it 'finds records by the params' do
      VCR.use_cassette('u_cmdb_ci_hosted_jde') do
        jdes = ServiceNow::UCmdbCiHostedJde.all({ sysparm_limit: 25 }, auth)
        expect(jdes[0]['sys_id']).to eql('0446c2a381dda1041166845afe757dc7')
      end
    end
  end
end
