=begin
显示文件内容，包括文件的文件名和文件内容
=end

require_relative 'modules/file_process'
require_relative 'modules/string_process'

# 源文件地址
sourceFilePath = 'F:/test1/002 白领丽人—杨静.txt'
fileInfo = FileProcess.getFileInfo sourceFilePath
puts "file title = #{fileInfo[:title]}"
puts '*' * 80
fileContent = fileInfo[:content]
fileContent = StringProcess.removeSpecifiedContent fileContent, [fileInfo[:title]]
fileContent = StringProcess.tripAllBlanks fileContent
fileContent = StringProcess.splitDocument fileContent
puts fileContent