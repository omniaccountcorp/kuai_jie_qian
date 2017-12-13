# coding: utf-8
module KuaiJieQian
  module ClientMethod
    module MerchantSign

      # 平台自身签署摘要
      # @param seal_position_info [hash] 签章信息
      #     * sign_type 签章类型，Single（单页签章）、Multi（多页签章）、Edges（签骑缝章）、Key（关键字签章）
      #     * pos_page 签署页码, 若为多页签章，支持页码格式“1-3,5,8“, 坐标定位时不可空
      #     * pos_type 默认0（若为关键字定位，签章类型（signType）必须指定为关键字定位才生效）
      #     * key 关键字
      #     * pos_x 签署位置X坐标
      #     * pos_y 签署位置Y坐标
      #     * width 印章展现高度
      #
      def merchant_sign(file_stream, sign_type, seal_position_info)
        path = "tech-sdkwrapper/timevale/sign/selfStreamSign"

        params = {
          :file => file_stream,
          :signType => sign_type,
          :signPos => seal_position_info.to_json,
        }

        KuaiJieQian::Http.post(@config[:host], @config[:project_config][:projectId], path, params, nil)
      end

      # 平台自身签署摘要
      # @param seal_position_info [hash] 签章信息
      #     * sign_type 签章类型，Single（单页签章）、Multi（多页签章）、Edges（签骑缝章）、Key（关键字签章）
      #     * pos_page 签署页码, 若为多页签章，支持页码格式“1-3,5,8“, 坐标定位时不可空
      #     * pos_type 默认0（若为关键字定位，签章类型（signType）必须指定为关键字定位才生效）
      #     * key 关键字
      #     * pos_x 签署位置X坐标
      #     * pos_y 签署位置Y坐标
      #     * width 印章展现高度
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
