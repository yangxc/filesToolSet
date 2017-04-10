=begin
组织所有的文本操作逻辑
=end
# -*- coding: utf-8 -*-
module StringProcess

  # 按照指定的分隔符进行文本的分割
  def self.splitDocument(document, terminator='。', exclude='」')
    # splitPattern = /#{terminator}[^」]/
    splitPattern = /#{terminator}(?!」)/
    results =  document.split splitPattern
    results.collect! do |item|
       item += terminator
    end
    return results
  end

  # 去除文档中的所有空白：空格、空行
  def self.tripAllBlanks(document)
    blankPattern = %r{\s+|　+}i
    if ! document.valid_encoding?
      document = document.encode("UTF-16be", :invalid=>:replace, :replace=>'').encode('UTF-8')
      return document.gsub(/dr/i,'med')
    end
    return document.gsub(blankPattern, '')
  end

  # 去除指定的行数
  def self.removeLines(document, rowNum=1)
    document.slice! 0...rowNum
  end

  # 全文去除指定的内容
  def self.removeSpecifiedContent(document, specifiedContents)
    if document.encoding != 'UTF-8'
      document = document.encode('UTF-8', 'GBK', :undef=> :replace, :invalid=>:replace, :replace=>'')
    end
    if ! document.valid_encoding?
      document = document.encode("UTF-16be", :invalid=>:replace, :replace=>'').encode('UTF-8')
    end
    specifiedContents.each do |content|
      document.gsub! content, ''
    end
    return document
  end

end