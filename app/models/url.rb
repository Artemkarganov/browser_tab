class Url < ApplicationRecord
  validates :url, presence: true, :format => URI::regexp(%w(http https))
  validates :name, presence: true

  def self.search(search)
    if search
     where('url LIKE ?', "%#{search}%")
    else
     all
    end
  end

  #belongs_to :user
end
