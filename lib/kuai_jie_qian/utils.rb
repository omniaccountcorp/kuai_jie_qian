# coding: utf-8

module KuaiJieQian
  module Utils
    #
    # 把 hash 中的 key，都转化为 symbol 类型
    # @param hash [Hash] 需要更改的 hash
    #
    # @return [Hash] 更改后的 hash
    #
    def self.symbolize_keys(hash)
      new_hash = {}
      hash.each do |key, value|
        new_hash[(key.to_sym rescue key) || key] = value
      end
      new_hash
    end

    def self.html_to_pdf(html_file_stream)
      kit = PDFKit.new(html_file_stream)
      kit.to_pdf
    end

    def self.pdf_to_png(pdf_file_path, png_path_dir, png_name)
      pngs = []

      pdf = Magick::ImageList.new(pdf_file_path){self.background_color = 'white'}

      pdf.each_with_index{ |obj, i|
        png_file_fullname ="#{png_path_dir}/#{png_name}_#{i+1}.png"
        res = obj.write(png_file_fullname)
        pngs << {fullname: png_file_fullname, successd: !res.nil?}
      }

      # pdf = Grim.reap(pdf_file_path)

      # KuaiJieQian.logger.info pdf_file_path
      # KuaiJieQian.logger.info pdf

      # count = pdf.count

      # KuaiJieQian.logger.info count

      # (0..count-1).each{ |i|
      #   png_file_fullname ="#{png_path_dir}/#{png_name}_#{i+1}.png"
      #   KuaiJieQian.logger.info i
      #   successd = pdf[i].save(png_file_fullname,
      #                         {:quality => 90, :alpha => "remove", :colorspace => "RGB"})
      #   pngs << {fullname: png_file_fullname, successd: successd}
      # }

      pngs
    end

  end # end module
end
