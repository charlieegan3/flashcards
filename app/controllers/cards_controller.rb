class CardsController < ApplicationController
  def index
    render json: Card.all.map(&:to_h)
  end

  def update
    cards = JSON.parse(request.body.string)
    existing_cards = Card.where(id: cards.map { |c| c["id"] })

    cards.each do |c|
      existing_card = existing_cards.find { |e| e.id == c["id"] }
      existing_card.update_supermemo!(c)
    end

    render json: Card.all.map(&:to_h)
  end
end
