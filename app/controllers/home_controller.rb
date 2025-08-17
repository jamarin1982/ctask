class HomeController < ApplicationController
  skip_before_action :protect_pages
  def index
  end
end
