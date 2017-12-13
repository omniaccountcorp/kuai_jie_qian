module KuaiJieQian
  module ClientMethod
    module UserSign

      def user_sign(account_id, seal_data, file_stream, sign_type, seal_position_info)
        path = "tech-sdkwrapper/timevale/sign/userStreamSign"

        params = {
          "accountId": account_id,
          "sealData": seal_data,
          "file": file_stream,
          "signType": sign_type,
          "signPos": seal_position_info.to_json
        }

        KuaiJieQian::Http.post(@config[:host], @config[:project_config][:projectId], path, params, nil)

      end

    end # end module
  end
end
