class PagesController < ApplicationController
  def root
    @title = "root"
  end

  def about
    @title = "about"
  end

  def about_ruin_rails
    @title = "about_ruin_rails"
  end
end