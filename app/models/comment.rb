class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many_attached :images

  validates :text, presence: true
end
