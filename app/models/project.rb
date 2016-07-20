class Project < ApplicationRecord
  def to_param
    slug
  end
end
