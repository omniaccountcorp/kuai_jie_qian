module KuaiJieQian
  module Logger

    def logger
      @logger ||= default_logger
    end

    def default_logger
      _logger = ::Logger.new(STDOUT)
      _logger.level = ::Logger::INFO
      _logger
    end

    def logger=(log)
      @logger = (log ? log : ::Logger.new('/dev/null'))
    end

  end
end
