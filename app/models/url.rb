class Url < ApplicationRecord
  validates :url, presence: true, :format => URI::regexp(%w(http https))
  validates :name, presence: true

  #belongs_to :user
end
