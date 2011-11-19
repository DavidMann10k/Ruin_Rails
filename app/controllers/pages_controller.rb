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
  
  def sign_in
    @title = "sign_in"
  end
end