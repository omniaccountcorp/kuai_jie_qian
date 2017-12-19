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
      puts pdf_file_path

      pdf = Grim.reap(pdf_file_path)
      pdf.each_with_index { |pdf_i, i|
        png_file_fullname ="#{png_path_dir}/#{png_name}_#{i+1}.png"
        puts png_file_fullname
        successd = pdf_i.save(png_file_fullname,
                              {:quality => 90, :alpha => "remove", :colorspace => "RGB"})

        pngs << {fullname: png_file_fullname, successd: successd}
      }
      pngs
    end

  end # end module
end
