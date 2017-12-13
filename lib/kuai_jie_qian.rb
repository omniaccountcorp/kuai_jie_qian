# coding: utf-8
require 'logger'
require "json"
require "rest-client"
require "pdfkit"
require "base64"

require "kuai_jie_qian/version"
require "kuai_jie_qian/logger"
require "kuai_jie_qian/utils"
require "kuai_jie_qian/http"

# 自动加载所有 client api
Dir["#{File.dirname(__FILE__)}/kuai_jie_qian/client_method/**/*.rb"].each { |file| require file }

require "kuai_jie_qian/client"

module KuaiJieQian
  # Your code goes here...
  extend KuaiJieQian::Logger
end

require 'kuai_jie_qian/railtie' if defined?(::Rails)
