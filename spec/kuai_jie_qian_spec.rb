# coding: utf-8
RSpec.describe KuaiJieQian do
  it "必须设置版本信息" do
    expect(KuaiJieQian::VERSION).not_to be nil
  end

  it '成功初始化客户端' do
    expect {
      client
    }.not_to raise_error
  end
end
