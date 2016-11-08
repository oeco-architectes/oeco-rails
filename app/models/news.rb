# frozen_string_literal: true

# News
class News < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :order, presence: true, uniqueness: true

  def img_url(width, height)
    Settings.data.news_img % {
      slug: slug,
      width: width,
      height: height
    }
  end
end
