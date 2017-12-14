# coding: utf-8
RSpec.describe '平台用户注册' do
  it "个人用户注册成功" do
    res = client.user_register("person", "山野鸠夫", "65322519740619695X", "RED", "RECTANGLE")


    expect(res[:account_id]).not_to eq(nil)
    expect(res[:seal_data]).not_to eq(nil)
  end

  it "公司用户注册成功" do
    res = client.user_register("company", "大众传媒", "358416983", "RED", "STAR", "NORMAL")


    expect(res[:account_id]).not_to eq(nil)
    expect(res[:seal_data]).not_to eq(nil)
  end
end
