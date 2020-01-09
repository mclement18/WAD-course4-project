class HomeController < ApplicationController
  def index
    @tips = Tip.most_recently_updated
  end
end
