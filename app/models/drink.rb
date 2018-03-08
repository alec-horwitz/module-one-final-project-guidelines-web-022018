class Drink < ActiveRecord::Base
  # has_many :bartenders
  has_many :bartender_drinks
  has_many :bartenders, through: :bartender_drinks
end


# drink_instance.bartenders #=> [bartender_instance1, bartender_instance2]
