=begin
准备激情文件
=end
# -*- coding: utf-8 -*-
require_relative 'modules/file_process'
require_relative 'modules/string_process'

sourceDir = 'f:/激情'
targetDir = 'f:/test2'

# 得到所有文件
fileList = FileProcess.showFilesList sourceDir

# 得到所有文件的标题和内容
fileInfos = []

fileList.each do |file|
  fileInfos << FileProcess.getFileInfo(file)
end

fileInfos.each do |file|
  fileTitle = file[:title]
  fileContent = file[:content]
  fileContent = StringProcess.removeSpecifiedContent fileContent, [fileTitle]
  fileTitle = StringProcess.removeSpecifiedContent fileTitle, [/\s+\d+\s+/]
  fileContent = StringProcess.removeSpecifiedContent fileContent, [fileTitle]
  puts '*' * 100
end