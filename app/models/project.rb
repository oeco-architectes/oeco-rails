# frozen_string_literal: true

# Project
class Project < ApplicationRecord
  def to_param
    slug
  end

  def img_url(width, height, index = 0)
    Settings.data.project_img % {
      index: index,
      slug: slug,
      width: width,
      height: height
    }
  end
end
