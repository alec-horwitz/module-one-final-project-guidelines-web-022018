class Tab < ActiveRecord::Base
  belongs_to :bartender
  belongs_to :customer
end
