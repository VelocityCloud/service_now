# frozen_string_literal: true

require 'spec_helper'

describe ServiceNow::SysUser do
  let(:auth) { { host: ENV['SN_HOST'], user: ENV['SN_USER'], password: ENV['SN_PASSWORD'] } }

  describe '.all' do
    it 'finds records by the params' do
      VCR.use_cassette('sys_users') do
        sys_users = ServiceNow::SysUser.all({ sysparm_limit: 25 }, auth)['result']
        expect(sys_users.size).to eql(25)
        expect(sys_users[0]['sys_id']).to eql('000d673968d3b10001fbb0343cff4e12')
      end
    end
  end

  describe '.find' do
    it 'finds a record by the sys id' do
      VCR.use_cassette('sys_user') do
        expect(ServiceNow::SysUser.find('000d673968d3b10001fbb0343cff4e12',
                                        auth)['result']['first_name']).to eql('Frank')
      end
    end
  end

  describe '.create' do
    xit 'creates a record' do
      VCR.use_cassette('create_sys_user') do
        params = {
          first_name: 'Karl',
          last_name: 'Allan',
          email: 'karl.allan@email.com',
          user_name: 'kallan'
        }
        expect(ServiceNow::SysUser.create(params, auth)['result']['sys_id']).to eql('9719345913621ec0fef07d322244b058')
      end
    end
  end

  describe '.update' do
    it 'updates a record' do
      VCR.use_cassette('update_sys_user') do
        params = { last_name: 'Miller' }
        expect(ServiceNow::SysUser.update('62d0a6100a0a3c5400d13bd0d4409f54', params,
                                          auth)['result']['last_name']).to eql('Miller')
      end
    end
  end
end
