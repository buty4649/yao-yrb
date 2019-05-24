require 'irb'
require 'yao'

module Yao
  module Yrb
    def self.run
      Yao.configure do
        auth_url             ENV['OS_AUTH_URL']
        tenant_name          ENV['OS_TENANT_NAME']
        username             ENV['OS_USERNAME']
        password             ENV['OS_PASSWORD']
        client_cert          ENV['OS_CERT']
        client_key           ENV['OS_KEY']
        region_name          ENV['OS_REGION_NAME']
        identity_api_version ENV['OS_IDENTITY_API_VERSION']
        user_domain_name     ENV['OS_USER_DOMAIN_NAME']
        project_domain_name  ENV['OS_PROJECT_DOMAIN_NAME']
        debug                ENV['YAO_DEBUG']
      end

      IRB.setup('yao')
      IRB.conf[:PROMPT] = { :YAO => {
        :PROMPT_I => 'yao(%m):%03n:%i> ',
        :PROMPT_N => 'yao(%m):%03n:%i> ',
        :PROMPT_S => 'yao(%m):%03n:%i%l ',
        :PROMPT_C => 'yao(%m):%03n:%i* ',
          :RETURN => "=> %s\n",
      }}
      IRB.conf[:PROMPT_MODE] = :YAO
      IRB::Irb.new.run(IRB.conf)
    end
  end
end
