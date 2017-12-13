module KuaiJieQian
  module ClientMethod
    module UserRegister

      def user_register(type, name, id, color, template_type, reg_type="NORMAL")
        if "person" == type
          account_id = create_person_account(name, id)
          seal_data = create_person_seal(account_id, color, template_type)
        elsif "company" == type
          account_id = create_company_account(name, id, reg_type)
          seal_data = create_company_seal(account_id, color, template_type)
        else
          raise "type 错误"
        end

        return { "account_id" => account_id, "seal_data" => seal_data}
      end


      private

      #创建个人用户账号
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
