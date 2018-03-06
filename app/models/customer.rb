class Customer < ActiveRecord::Base
  #Yes, customers can tabs with multible bartenders
  has_many :tabs
  has_many :bartenders, through: :tabs

  def createTab(cost, bart)
    Tab.create(customer_id: self.id, bartender_id: bart.id, amount_due: cost, drinks_purchased: 1)
  end

  def updateTab(cost, bart)
    t = Tab.find_by(bartender_id: bart.id, customer_id: self.id)
    if t
      t.amount_due += cost
      t.drinks_purchased = t.drinks_purchased + 1
      t.save
    end
  end

  def addTab(dranks, bart)
    dranks.each {|drink|
      if bart.drinks.split(", ").include?(drink)
        if !Tab.find_by(bartender_id: bart.id, customer_id: self.id)
          self.createTab(10, bart)
        else
          self.updateTab(10, bart)
        end
      else
        puts "I Don't know what that is..."
      end
    }
  end
end
