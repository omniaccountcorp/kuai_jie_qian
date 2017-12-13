# coding: utf-8
module KuaiJieQian
  class Client

    def initialize(options_arg)
      options = Utils.symbolize_keys(options_arg)
      @config = {
        host: options[:host],
        project_config: options[:project_config],
        http_config: options[:http_config],
        sign_config: options[:sign_config],
      }

      init_server

      # 自动 include api 下的模块
      recursive_include_api('KuaiJieQian::ClientMethod')
    end # initialize

    private
    def init_server
      params = {
        projectConfig: @config[:project_config],
        httpConfig: @config[:http_config],
        signConfig: @config[:sign_config],
      }

      path = "tech-sdkwrapper/timevale/init"

      # 向 java 服务器初始化
      res = KuaiJieQian::Http.post(@config[:host], @config[:project_config][:projectId], path, params)

      raise "初始化失败：#{res[:msg]}" if '0' != res[:errCode].to_s
    end

    def recursive_include_api(module_chain)
      modules = eval("#{module_chain}.constants").each{ |constant| eval("#{module_chain}::#{constant}").class.kind_of?(Module) }

      if modules.empty?
        self.class.send(:include, eval(module_chain))
      else
        modules.each{ |constant| recursive_include_api("#{module_chain}::#{constant}") }
      end
    end

  end # class
end
