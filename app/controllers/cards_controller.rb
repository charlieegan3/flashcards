class CardsController < ApplicationController
  def index
    @cards = Card.all.order(:deck)
  end
end
