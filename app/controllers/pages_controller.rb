class PagesController < ApplicationController

  def index
    @pages = current_user.pages
  end
end
