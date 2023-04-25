class Payment < ApplicationRecord
    has_one :bill
    belongs_to :rider
    belongs_to :driver
end
