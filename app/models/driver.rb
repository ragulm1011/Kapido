class Driver < ApplicationRecord
   
    #Associations
    has_one_attached :liscense_image , dependent: :destroy
    has_one :user , as: :userable , dependent: :destroy
    
    has_and_belongs_to_many :vehicles , join_table: :drivers_vehicles
    has_many :payments
    has_many :riders , through: :payments
   has_many :rides

    #Validations    
    validates :liscense_no , :driver_rating , presence: true
    validates :driver_rating, numericality: { less_than_or_equal_to: 5 , greater_than_or_equal_to: 0}


    scope :rating_less_than_3 , -> { Driver.where("driver_rating < ?" , 3) }
    scope :rating_greater_than_3 , -> { Driver.where("driver_rating >= ?" , 3) }

end
