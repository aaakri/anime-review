class Anime < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :title, presence: true, length: { maximum: 255 }
end
