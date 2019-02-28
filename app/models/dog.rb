class Dog < ApplicationRecord
  belongs_to :owner
  has_many :playdates, dependent: :destroy

  validates :name, presence: true
  validates :breed, presence: true

  def avg_rating
    return ratings.sum / ratings.size unless ratings.empty?

    return 0
  end
end
