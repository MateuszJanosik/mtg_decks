class Comment < ApplicationRecord
  attr_accessor :related_gid
  belongs_to :user
  belongs_to :related, polymorphic: true
end
