class Url < ApplicationRecord

  after_create :screenshot

  validates :url, presence: true, :format => URI::regexp(%w(http https))
  validates :name, presence: true

  def self.search(search)
    if search
     where('url LIKE ?', "%#{search}%")
    else
     all
    end
  end

  def screenshot
    screenshot = Gastly.screenshot(url, timeout: 1000)
    image = screenshot.capture
    image.resize(width: 110, height: 110)
    image.format('png')
    image.save('output.png')
  end

  belongs_to :user
end
