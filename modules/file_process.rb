=begin
组织所有的文件及目录操作逻辑
=end
# -*- coding: utf-8 -*-

module FileProcess
  # 显示指定目录下文件集合
  def self.showFilesList(directory, encoding='utf-8')
    # 保存当前目录下所有文件的名称
    fileNames = []
    Dir.foreach(directory, encoding: encoding) do |x|
      next if x == '.' || x == '..'
      absolutePath = File.absolute_path(x, directory)
      if File.directory? absolutePath
        fileNames.push(showFilesList absolutePath)
      else
        fileNames.push absolutePath
      end
    end
    return fileNames
  end

  # 获取文件内容，包括文件题目和内容
  def self.getFileInfo(filePath, suffix='.txt', internal_encoding='utf-8', external_encoding='gbk')
    fileInfo = {}
    # 把文件名称作为文件的标题
    fileInfo[:title] = File.basename(filePath, suffix)
    File.open(filePath, 'r:gbk') do |f|
      fileInfo[:content] =  f.read
    end
    return fileInfo
  end

  def self.saveFile(fileInfo, targetDir, suffix='.txt', internal_encoding='utf-8', external_encoding='gbk')
    filePath = File.join targetDir, fileInfo[:title]
    filePath += suffix
    File.open(filePath, 'w', internal_encoding: internal_encoding, external_encoding: internal_encoding) do |f|
      f.puts fileInfo[:content]
    end
  end

end