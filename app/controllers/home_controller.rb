class HomeController < ApplicationController
  def index
    @news = News.order(:order).all
  end
end
