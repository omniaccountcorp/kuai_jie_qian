# coding: utf-8
RSpec.describe '用户签名' do
  it "个人用户签名成功" do
    pdf_file_path = "#{File.dirname(__FILE__)}/../tmp/test.pdf"
    begin
      pdf_file_stream = File.new(pdf_file_path, 'rb')
    rescue
      html_file_stream = File.new('spec/factory/test.html')
      pdf_file_stream = KuaiJieQian::Utils.html_to_pdf(html_file_stream)
      File.write(pdf_file_path, pdf_file_stream)
    end

    seal_position_info = {
      "postPage" => "1",
      "posType" => 1,
      "key" => "提前还款",
      "posX" => 40,
      "posY" => 0,
      "width" => 80
    }

    person = client.user_register("person", "山野鸠夫", "65322519740619695X", "RED", "RECTANGLE")
    KuaiJieQian.logger.info "person: [#{person}]\n"
    res = client.user_sign(person["account_id"], person["seal_data"], pdf_file_stream, 'Key', seal_position_info)

    if '0' ==res[:errCode].to_s
      file_content = Base64.decode64(res[:stream])
      File.write("tmp/user_sign.pdf", file_content)
    end
  end

  it "平台用户签名成功" do

  end
end
