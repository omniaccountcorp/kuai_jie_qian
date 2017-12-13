module KuaiJieQian
  class Railtie < ::Rails::Railtie
    initializer "KuaiJieQian.logger" do
      KuaiJieQian.logger = Rails.logger
    end
  end
end
