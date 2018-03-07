require_relative '../config/environment'

require "pry"

c = Customer.first
puts "Welcome"

exit = false

bart = Bartender.all.sample

while exit == false

  puts "Bartender "+bart.name+": \"What can I do for you?\""
  puts "Your options are as follows:"
  puts "-----------------------------------"
  puts "1) Show drink menu"
  puts "2) Place an order"
  puts "3) Show my tab"
  puts "4) Close my tab"
  puts "5) Leave (i.e. exit)"
  puts "-----------------------------------\n\n"
  puts "(To pick a menu option, type its corrisponding number in the console and hit enter)\n\n"

  ans = gets.chomp.to_i

  case ans
  when 1
    puts "\n\nBartender "+bart.name+": \"Here's what I can make for you\":"
    puts "-----------------------------------"
    puts bart.drinks.map {|drink| drink.name}
    puts "-----------------------------------\n\n"
    puts "(hit enter to continue)"
    gets
    puts "\n\n"
  when 2
    puts "\n\nBartender "+bart.name+": \"What would you like to order?\""
    puts "(Type your drinks into the console dilimited by ', 's and then press enter)"
    order = gets.chomp.split(", ")
    c.buyARound(order, bart)
    bart = Bartender.all.sample
    puts "\n\n"
  when 3
    puts "\n\nBartender "+bart.name+": \"Here's what your tab looks like\":"
    puts "-----------------------------------"
    totDrinks = 0
    total = 0
    Tab.all.select {|tab|
      tab.customer_id == c.id
    }.each {|tab|
      totDrinks = totDrinks + tab.drinks_purchased
      total = total + tab.amount_due
    }
    puts "Number of Drinks Purchased: "+(totDrinks).to_s
    puts "Your Total: "+(total).to_s
    puts "-----------------------------------\n\n"
    puts "(hit enter to continue)"
    gets
    puts "\n\n"
  when 4
    puts "\n\nBartender "+bart.name+": \"Okay, just sign here.\""
    puts "(hit enter to sign)"
    gets
    # binding.pry
    Tab.all.select {|tab|
      tab.customer_id == c.id
    }.each {|tab|
      puts "Charging $" + tab.amount_due.to_s + "to your card."
      tab.delete
    }
    # binding.pry
    puts "Bartender "+bart.name+": \"Great! Here's your card back.\"\n\n"
  when 5
    exit = true
    puts "\n\n"+"Bartender "+bart.name+": \"Bye forever...\" (laughs ominously)\n\n"
  else
    puts "\n\n"+"Bartender "+bart.name+": I'm not sure what that means...\n\n"
  end

end







# c.buyARound(["Vodka","Merlot","surprise me","Whiskey Ginger","Plain Old Beer","Water","surprise me","Water"])
