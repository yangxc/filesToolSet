=begin
写入文件
=end
require_relative 'modules/file_process'
sourceFilePath = 'F:/test1/002 白领丽人—杨静.txt'
fileInfo = FileProcess.getFileInfo sourceFilePath
FileProcess.saveFile fileInfo, 'f:/test2'