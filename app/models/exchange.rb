class Exchange < ApplicationRecord
  has_many :markets, inverse_of: :exchange
end
