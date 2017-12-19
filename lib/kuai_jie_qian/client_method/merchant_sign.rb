# coding: utf-8

module KuaiJieQian
  module ClientMethod
    module MerchantSign
      #
      # 平台自身签署摘要(文件流)
      # @param file_stream [file] 文件流
      # @param seal_position_info [hash] 签章信息
      #   * pos_page [String] 签署页码, 若为多页签章，支持页码格式“1-3,5,8“, 坐标定位时不可空
      #   * pos_type [Integer] 默认0（若为关键字定位，签章类型（signType）必须指定为关键字定位才生效）
      #   * key [String] 关键字
      #   * pos_x [Float] 签署位置X坐标
      #   * pos_y [Float] 签署位置Y坐标
      #   * width [Float] 印章展现高度
      # @param sign_type [String] 签章类型，Single（单页签章）、Multi（多页签章）、Edges（签骑缝章）、Key（关键字签章）
      #
      # @return [ Hash ] 结果集
      #   * errCode [Integer] 错误码
      #   * msg [String] 错误信息
      #   * errShow [Boolean] 错误信息是否显示
      #   * signServiceId [String] 签署记录id
      #   * stream [String] 签署后的文件 base64
      #
      def merchant_sign(file_stream, seal_position_info, sign_type="Key")
        path = "tech-sdkwrapper/timevale/sign/selfStreamSign"

        params = {
          :file => file_stream,
          :signType => sign_type,
          :signPos => seal_position_info.to_json,
        }

        result = KuaiJieQian::Http.post(@config[:host], @config[:project_config][:projectId], path, params, nil)

        Base64.decode64(result[:stream])
      end
      #
      # 平台自身签署摘要(本地)
      # @param file_info [Hash]
      #   * srcPdfFile [String] 待签署PDF文档本地路径
      #   * dstPdfFile [String] 签署后PDF文档本地路径
      #   * fileName [String] 文档名称
      #   * ownerPassword [String] 文档编辑密码
      # @param sign_type [String] 签章类型，Single（单页签章）、Multi（多页签章）、Edges（签骑缝章）、Key（关键字签章）
      # @param sign_pos [String] 签章信息
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
      #
      def merchant_sign_with_file(file_info, sign_type, sign_pos)
        path = "tech-sdkwrapper/timevale/sign/selfFileSign"

        params = {
          :signPos => sign_pos,
          :signType => sign_type,
          :file => file_info,
        }

        KuaiJieQian::Http.post(@config[:host], @config[:project_config][:projectId], path, params)
      end

    end # end module
  end
end
