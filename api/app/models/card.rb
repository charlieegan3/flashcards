class Card < ApplicationRecord
  def update_supermemo!(params)
    if factor != params["factor"] || schedule != params["schedule"]
      return update!(
        factor: params["factor"],
        count: (count || 0) + 1,
        schedule: params["schedule"],
      )
    end

    false
  end

  def to_h
    {
      id: id,
      deck: deck,
      question: question,
      answer: answer,
      factor: factor,
      schedule: schedule,
      count: count || 0,
    }
  end
end
