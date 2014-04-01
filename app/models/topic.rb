class Topic < ActiveRecord::Base
  has_many :posts
  default_scope { order('updated_at DESC') }
end
