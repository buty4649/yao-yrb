require 'clamp'
require 'yao'
require 'irb'

# [HACK] allow optional and multivalued parameters
original_verbosity = $VERBOSE
$VERBOSE = nil
Clamp::Parameter::Definition::ELLIPSIS_SUFFIX = / \.\.\.\]?$/.freeze
$VERBOSE = original_verbosity

module Yao
  module Yrb
    class Cli < Clamp::Command
      option '--version', :flag, 'Show version' do
        puts Yao::Yrb::VERSION
        exit(0)
      end

      parameter '[FILE ...]', 'Execute the contents of FILE. If unset, run in Interpreter mode.',
                attribute_name: :script_mode

      def execute
        yao_setup

        if script_mode.size.positive?
          script_file = script_mode.first
          load script_file
        else
          IRB.setup(__FILE__)
          conf = IRB.conf
          conf[:AP_NAME] = 'yrb'
          conf[:IRB_NAME] = 'yrb'
          irb = IRB::Irb.new
          irb.run(conf)
        end
      end

      def yao_setup
        Yao.configure do
          auth_url              ENV['OS_AUTH_URL']
          tenant_name           ENV['OS_TENANT_NAME']
          username              ENV['OS_USERNAME']
          password              ENV['OS_PASSWORD']
          ca_cert               ENV['OS_CACERT']
          client_cert           ENV['OS_CERT']
          client_key            ENV['OS_KEY']
          region_name           ENV['OS_REGION_NAME']
          identity_api_version  ENV['OS_IDENTITY_API_VERSION']
          user_domain_name      ENV['OS_USER_DOMAIN_NAME']
          project_domain_name   ENV['OS_PROJECT_DOMAIN_NAME']
          debug                 ENV['YAO_DEBUG']
          debug_record_response ENV['YAO_DEBUG_RECORD_RESPONSE']
        end
      end
    end
  end
end
