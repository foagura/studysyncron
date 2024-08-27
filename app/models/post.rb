class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many_attached :images

  with_options presence: true do
    validates :study_hours, numericality: { only_integer: true, in: 0..23 }
    validates :study_minutes, numericality: { only_integer: true, in: 0..59 }
    validates :title, :content, :start_time
  end
end
