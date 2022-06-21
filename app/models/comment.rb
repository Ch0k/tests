class Comment < ApplicationRecord
  resourcify
  belongs_to :commentable, polymorphic: true
  validates :body, presence: true
end
