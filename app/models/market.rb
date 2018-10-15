class Market < ApplicationRecord
  belongs_to :exchange, inverse_of: :markets
end

