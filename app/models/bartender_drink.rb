class BartenderDrink < ActiveRecord::Base
  #Yes, bartenders mantain their tabs indevidualy
  belongs_to :drink
  belongs_to :bartender
  # has_many :BartenderDrinks
  # has_many :drinks, through: :BartenderDrinks
  # has_many :customers, through: :tabs
end
