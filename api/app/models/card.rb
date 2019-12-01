class Card < ApplicationRecord
  def update_supermemo!(params)
    if factor != params["factor"] || schedule != params["schedule"]
      return update!(factor: params["factor"], schedule: params["schedule"])
    end

    false
  end
end
