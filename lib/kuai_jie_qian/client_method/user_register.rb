# coding: utf-8

module KuaiJieQian
  module ClientMethod
    module UserRegister
      #
      # 平台用户注册，生成签章
      # @param name [String] 用户名
      # @param id [String] 个人：用户证件号／护照号，公司：组织机构代码、工商注册号或者统一社会信用代码
      # @param color [String] 生成印章的颜色，RED（红色）、BLACK（黑色）、BLUE（蓝色）
      # @param template_type [String] 印章模板类型
      # @param reg_type [String] 个人取值：PERSONAL，公司取值：NORMAL（组织机构代码）、MERGE（社会信用代码）、REGCODE（工商注册号）
      #
      # @return [ Hash ] 结果集
      #   * account_id [String] 账户标识
      #   * seal_data [String] 电子印章图片base64数据
      #
      def user_register(name, id, color, template_type, reg_type)
        account_id = if 'PERSONAL' == reg_type
                       create_person_account(name, id)
                     else
                       create_company_account(name, id, reg_type)
                     end

        seal_data = create_company_seal(account_id, color, template_type)

        return { :account_id => account_id, :seal_data => seal_data}
      end


      private

      # 创建个人用户账号
      def create_person_account(user_name, id)
        path = "tech-sdkwrapper/timevale/account/addPerson"
        params = {
        	"name": user_name,
        	"idNo": id
        }
        account_data = KuaiJieQian::Http.post(@config[:host], @config[:project_config][:projectId], path, params)
        return account_data[:accountId]
      end

      #创建个人用户印章
      def create_person_seal(account_id, color, template_type)
        path = "tech-sdkwrapper/timevale/seal/addPersonSeal"
        params = {
          "accountId": account_id,
          "color": color,
          "templateType": template_type
        }
        seal_data = KuaiJieQian::Http.post(@config[:host], @config[:project_config][:projectId], path, params)
        return seal_data[:sealData]
      end

      #创建企业用户账号
      def create_company_account(name, id, reg_type)
        path = "tech-sdkwrapper/timevale/account/addOrganize"
        params = {
        "name": name ,
        "organCode": id,
        "regType": reg_type
      }
      account_data = KuaiJieQian::Http.post(@config[:host], @config[:project_config][:projectId], path, params)
      return account_data[:accountId]
      end

      #创建企业用户印章
      def create_company_seal(account_id, color, template_type)
        path = "tech-sdkwrapper/timevale/seal/addOrganizeSeal"
        params = {
          "accountId": account_id,
          "color": color,
          "templateType": template_type
        }
        seal_data = KuaiJieQian::Http.post(@config[:host], @config[:project_config][:projectId], path, params)
        return seal_data[:sealData]
      end

    end # end module
  end
end
