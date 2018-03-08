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

  def addTab(drink, bart)
    cost = rand(5..40)
    if !Tab.find_by(bartender_id: bart.id, customer_id: self.id)
      self.createTab(cost, bart)
    else
      self.updateTab(cost, bart)
    end
    puts "\n\n"
    puts "Bartender "+bart.name+": \"Here's your "+drink.capitalize+"!"
  end

  def learnNewDrink(drink, bart)
    # binding.pry
    if drink.downcase == "surprise me"
      drink = bart.drinks.map {|bartDrink| bartDrink.name}.sample
      addTab(drink, bart)
    else
      puts "\n\n"
      puts "Bartender "+bart.name+": \"I'm not sure what a " + drink + " is but I'll make it for you if you tell me how?"
      nahs = ["nah","no", "forget", "don't", "not", "n"]
      ans = gets.chomp
      # binding.pry
      if !ans.downcase.split(" ").any? {|w| nahs.include?(w)}
        bart.drinks.push(Drink.create(name: drink))
        addTab(drink, bart)
      else
        puts "\n\n"
        puts "Bartender "+bart.name+": \"Whatever..."
      end
    end
  end

  def buyARound(dranks, bart)

    # bartendDrinks = bart.drinks.map {|bartDrink| bartDrink.name}

    dranks.each {|drink|
      if bart.drinks.map {|bartDrink| bartDrink.name.downcase}.include?(drink.downcase)
        addTab(drink.downcase, bart)
      else
        learnNewDrink(drink.downcase, bart)
      end
    }
  end
end
