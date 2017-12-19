# coding: utf-8

module KuaiJieQian
  module Http

    def self.post(host, project_id, path, params, content_type='application/json')
      final_url = "#{host}/#{path}"
      header = {
        "X-timevale-mode" => "package",
        "X-timevale-project-id" => project_id,
        "X-timevale-signature-algorithm" => "hmac-sha256",
      }.merge({'Content-Type' => content_type})

      if "application/json" == content_type
        request_body = params.to_json
      else
        request_body = params
      end

      KuaiJieQian.logger.info "post [#{final_url}] with header: [#{header}], params: [#{params}]"

      response = RestClient.post(final_url, request_body, header)

      KuaiJieQian.logger.debug "post [#{final_url}] got result: [#{response}]\n"

      begin
        res = Utils.symbolize_keys(JSON.parse(response))
      rescue
        raise "post [#{final_url}] 解析结果出错"
      end

      KuaiJieQian.logger.debug "res: [#{res}]\n"
      res
    end

  end # end module
end
