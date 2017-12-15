# coding: utf-8

module KuaiJieQian
  module ClientMethod
    module UserSign
      #
      # 平台用户签署摘要(文件流)
      # @param account_id [String] 签署账户标识
      # @param seal_data [String] 印章图片base64
      # @param file_stream [file] 文件流
      # @param sign_type [String] 签章类型，Single（单页签章）、Multi（多页签章）、Edges（签骑缝章）、Key（关键字签章）
      # @param seal_position_info [hash] 签章信息
      #   * pos_page [String] 签署页码, 若为多页签章，支持页码格式“1-3,5,8“, 坐标定位时不可空
      #   * pos_type [Integer] 默认0（若为关键字定位，签章类型（signType）必须指定为关键字定位才生效）
      #   * key [String] 关键字
      #   * pos_x [Float] 签署位置X坐标
      #   * pos_y [Float] 签署位置Y坐标
      #   * width [Float] 印章展现高度
      #
      # @return [ Hash ] 结果集
      #   * errCode [Integer] 错误码
      #   * msg [String] 错误信息
      #   * errShow [Boolean] 错误信息是否显示
      #   * signServiceId [String] 签署记录id
      #   * stream [String] 签署后的文件base64
      #
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
