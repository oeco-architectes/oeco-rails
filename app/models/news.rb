class News < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :order, presence: true, uniqueness: true

  def img_url
    s = Settings.data
    URI("#{s.base_url}/#{s.news_url}/#{slug}.#{s.img_ext}")
  end
end
