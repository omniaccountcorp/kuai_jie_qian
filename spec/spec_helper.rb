require "bundler/setup"
require "kuai_jie_qian"

module KuaiJieQianSupport
  def client
    project_config = {
      projectId: '1111563517',
      projectSecret: '95439b0863c241c63a861b87d1e647b7',
      itsmApiUrl: 'http://121.40.164.61:8080/tgmonitor/rest/app!getAPIInfo2'
    }

    http_config = {
      proxyIp: "",
      proxyPort: "",
      retry: "",
      httpType: 'HTTP'
    }

    sign_config = {
      algorithm: 'HMACSHA256',
      privateKey: "",
      esignPublicKey: ""
    }

    @client ||= KuaiJieQian::Client.new(host: 'http://10.0.0.102:8080',
                                        project_config: project_config,
                                        http_config: http_config,
                                        sign_config: sign_config)

    @client
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include KuaiJieQianSupport
end
