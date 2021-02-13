class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @flats = Flat.last(6)
  end
end
