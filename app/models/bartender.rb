class Bartender < ActiveRecord::Base
  has_many :tabs
  has_many :customers, through: :tabs
end
