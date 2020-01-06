class HomeController < ApplicationController
  def index
    @tips = Tip.most_recent
  end
end
