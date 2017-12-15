# coding: utf-8
RSpec.describe '平台签名' do
  it "成功" do
    pdf_file_path = "#{File.dirname(__FILE__)}/../tmp/借款协议.pdf"
    begin
      pdf_file_stream = File.new(pdf_file_path, 'rb')
    rescue
      html_file_stream = File.new('spec/factory/test.html')
      pdf_file_stream = KuaiJieQian::Utils.html_to_pdf(html_file_stream)
      File.write(pdf_file_path, pdf_file_stream)
    end

    seal_position_info = {
      "posPage" => "1-6",
      "posType" => 1,
      "key" => "提前还款",
      "posX" => 40,
      "posY" => 0,
      "width" => 80
    }
    res = client.merchant_sign(pdf_file_stream, 'Key', seal_position_info)

    if '0' ==res[:errCode].to_s
      file_content = Base64.decode64(res[:stream])
      File.write("tmp/merchant_sign.pdf", file_content)

      KuaiJieQian::Utils.pdf_to_png("tmp/merchant_sign.pdf")

      # pdf = Magick::ImageList.new("tmp/merchant_sign.pdf")
      # thumb = pdf.scale(300, 300) { self.background_color = "white" }
      # pdf.background_color = "white"
      # pdf.write "tmp/merchant_sign.png"
    end
  end

  it "服务器本地文件，成功" do
    pdf_file_path = "/tmp/test.pdf"
    pdf_file_dst_path = "/tmp/merchant_local_sign.pdf"

    sign_pos = {
      "posPage" => "1",
      "posType" => 1,
      "key" => "提前还款",
      "posX" => 40,
      "posY" => 0,
      "width" => 80
    }

    file_info = {
      srcPdfFile: pdf_file_path,
      dstPdfFile: pdf_file_dst_path,
      fileName: '',
      ownerPassword: '',
    }

    res = client.merchant_sign_with_file(file_info, 'Key', sign_pos)

  end
end
