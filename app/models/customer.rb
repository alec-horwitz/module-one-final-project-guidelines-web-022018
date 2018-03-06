class Customer < ActiveRecord::Base
  has_many :tabs
  has_many :bartenders, through: :tabs
end
