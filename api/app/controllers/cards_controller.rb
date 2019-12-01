class CardsController < ApplicationController
  def index
    render json: Card.all
  end

  def update
    cards = JSON.parse(request.body.string)
    existing_cards = Card.where(id: cards.map { |c| c["id"] })

    results = cards.map do |c|
      existing_card = existing_cards.find { |e| e.id == c["id"] }
      existing_card.update_supermemo!(c)
    end

    render json: { message: "updated #{results.count(true)}" }
  end
end
