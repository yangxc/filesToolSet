=begin
处理wordpress数据
=end

require_relative 'modules/wp_data_process'

aa = WpDataProcess::Post.posts
aa.posts.each do |post|
  puts "title: #{post.post_title}"
  print 'Tags: '
  post.taxonomies.each do |taxonomy|
    print "#{taxonomy.name}"
  end
  puts
end