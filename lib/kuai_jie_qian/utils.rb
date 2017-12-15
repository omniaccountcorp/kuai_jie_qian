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

    def self.pdf_to_png(file)
      pdf = Grim.reap(file)
      png = pdf[0].save(file.split(".").first + '.png',
                        {:quality => 90, :alpha => "remove", :colorspace => "RGB"}
                      )

    end

  end # end module
end
