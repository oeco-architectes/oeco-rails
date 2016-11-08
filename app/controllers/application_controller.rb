# frozen_string_literal: true

# Controller's superclass
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Enable HTTP Basic Authentication if AUTH_USERNAME and AUTH_PASSWORD are set.
  # This allows protecting staging and review platforms.
  if ENV.key?('AUTH_USERNAME') && ENV.key?('AUTH_PASSWORD')
    http_basic_authenticate_with name: ENV['AUTH_USERNAME'], password: ENV['AUTH_PASSWORD']
  end
end
