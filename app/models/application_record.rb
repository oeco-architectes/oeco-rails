# frozen_string_literal: true

# Application records superclass
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
