require 'clamp'
require 'yao'
require 'pry'

# [HACK] allow optional and multivalued parameters
original_verbosity = $VERBOSE
$VERBOSE = nil
Clamp::Parameter::Definition::ELLIPSIS_SUFFIX = / \.\.\.\]?$/
$VERBOSE = original_verbosity

module Yao::Yrb
  class Cli < Clamp::Command
    option '--version', :flag, 'Show version' do
      puts Yao::Yrb::VERSION
      exit(0)
    end

    parameter '[FILE ...]', 'Execute the contents of FILE. If unset, run in Interpreter mode.',
              attribute_name: :script_mode

    def execute
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

      if script_mode.size > 0
        script_file = script_mode.first
        load script_file
      else
        opts = Pry::CLI.parse_options([])
        Pry.config.prompt_name = "yao"
        Pry::CLI.start(opts)
      end

    end
  end
end
