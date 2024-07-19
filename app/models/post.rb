class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  with_options presence: true do
    validates :study_hours, :study_minutes, numericality: { only_integer: true }
    validates :title, :content, :start_time
  end
end
