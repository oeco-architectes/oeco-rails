# frozen_string_literal: true

# Home page controller
class HomeController < ApplicationController
  def index
    @news = News.order(:order).all
  end
end
