class Bartender < ActiveRecord::Base
  #Yes, bartenders mantain their tabs indevidualy
  has_many :tabs
  has_many :customers, through: :tabs
end
