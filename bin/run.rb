require_relative '../config/environment'
require "pry"

def main()
  puts Artii::Base.new.asciify('Bar').colorize(:blue)
  puts Artii::Base.new(:font => 'slant').asciify('Tender').colorize(:red)
  puts "Please Enter Your Name Into The Console To Begin: "
  name = gets.chomp
  c = Customer.create(name: name)
  puts "\n\n\nWelcome " + name + "\n\n\n"
  bart = Bartender.all.sample
  exit = false

  while exit == false
    show_options(bart)
    ans = gets.chomp.to_i
    case ans
    when 1
      show_drink_menu(bart)
    when 2
      place_an_order(c, bart)
    when 3
      show_my_tab(c, bart)
    when 4
      close_my_tab(c, bart)
    when 5
      exit = true
      puts "\n\n"+"Bartender "+bart.name+": \"Bye forever...\" (laughs ominously)\n\n"
    else
      puts "\n\n"+"Bartender "+bart.name+": I'm not sure what that means...\n\n"
    end
  end
end

def show_options(bart)
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
end

def show_drink_menu(bart)
  puts "\n\nBartender "+bart.name+": \"Here's what I can make for you\":"
  puts "-----------------------------------"
  puts bart.drinks.map {|drink| drink.name}
  puts "-----------------------------------\n\n"
  puts "(hit enter to continue)"
  gets
  puts "\n\n"
end

def place_an_order(c, bart)
  puts "\n\nBartender "+bart.name+": \"What would you like to order?\""
  puts "(Type your drinks into the console dilimited by ', 's and then press enter)"
  order = gets.chomp.split(", ")
  c.buyARound(order, bart)
  bart = Bartender.all.sample
  puts "\n\n"
end

def show_my_tab(c, bart)
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
end

def close_my_tab(c, bart)
  puts "\n\nBartender "+bart.name+": \"Okay, just sign here.\""
  puts "(hit enter to sign)"
  gets
  Tab.all.select {|tab|
    tab.customer_id == c.id
  }.each {|tab|
    puts "Charging $" + tab.amount_due.to_s + "to your card."
    tab.delete
  }
  puts "Bartender "+bart.name+": \"Great! Here's your card back.\"\n\n"
end

main()
