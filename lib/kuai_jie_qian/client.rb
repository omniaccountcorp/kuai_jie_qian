# coding: utf-8

module KuaiJieQian
  class Client
    #
    # 初始化SDK
    # @param options_arg [Hash] 配置信息
    #   * host [String] java服务器 IP:port
    #   * project_config [Hash] 项目信息
    #   * http_config [Hash] 协议信息
    #   * sign_config [Hash] 签名信息
    #
    # @return [ Hash ] 结果集
    #   * errCode [Integer] 错误码
    #   * msg [String] 错误信息
    #   * errShow [Boolean] 错误信息是否显示
    #
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
