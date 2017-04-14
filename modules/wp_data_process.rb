=begin
组织wordpress数据库操作逻辑
=end
# -*- coding: utf-8 -*-
require 'active_record'


module WpDataProcess
  ActiveRecord::Base.establish_connection(
      adapter:  'mysql2',
      host:     'localhost',
      username: 'lulu',
      password: 'lulu',
      database: 'lulu'
  )

  # 显示joomla中的用户
  class User < ActiveRecord::Base
    self.table_name = 'wp_users'
    # 只关联帖子，不关联分类等此用户建立的其他内容
    has_many :posts, -> {where post_type: 'post'}, foreign_key: 'post_author'

    # 创建一个帖子
    def create_post

    end

    # 创建一个分类
    def createCategory

    end

    # 创建一个标签
    def createTag

    end
  end

  class Post < ActiveRecord::Base
    self.table_name = 'wp_posts'
    belongs_to :user
    has_and_belongs_to_many :taxonomies, join_table: 'wp_term_relationships', foreign_key: 'object_id',
                            association_foreign_key: 'term_taxonomy_id'
    # 获取所有的帖子
    def self.posts
      Post.where(post_type: 'post')
    end

    # 获取所有的图片
    def self.images
      Post.where(post_type:'attachment', post_mime_type: 'image/png')
    end
  end

  # 代表文章等的分类和标签的名称
  class Term < ActiveRecord::Base
    self.table_name = 'wp_terms'
    self.primary_key = 'term_id'

    has_one :taxonomy, :class_name => 'Taxonomy', dependent: :destroy

  end

  # 对文章等的分类和标签的名称进行分类
  class Taxonomy < ActiveRecord::Base
    self.table_name = 'wp_term_taxonomy'
    self.primary_key = 'term_taxonomy_id'
    belongs_to :term
    has_and_belongs_to_many :posts, join_table: 'wp_term_relationships', foreign_key: 'term_taxonomy_id',
                            association_foreign_key: 'object_id'

    # 得到所有的分类目录
    def self.Categories
      where taxonomy: 'category'
    end

    # 得到所有的标签
    def self.Tags
      where taxonomy: 'post_tag'
    end

    def name
      self.term.name
    end

  end


end