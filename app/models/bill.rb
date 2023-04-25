class Bill < ApplicationRecord
    belongs_to :ride
    belongs_to :payment
end
