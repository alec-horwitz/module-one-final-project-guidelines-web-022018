Bartender.destroy_all
Tab.destroy_all
Customer.destroy_all

liquors = ["Vodka", "Whiskey", "Rum", "Tequila", "Bourbon", "Scotch"]
wines = ["Merlot", "Cabernet", "Malbec", "Pinot Noir", "Moscato", "Chardonnay", "Pinot Grigio", "Sauvignon Blanc", "Rose\'"]
allDrinks = ["Screwdriver", "Whiskey Ginger"] + liquors + wines
10.times {allDrinks = allDrinks + [Faker::Beer.style]}



ba = Bartender.create(name: "Bob")
bb = Bartender.create(name: "Alice")

allDrinks.each {|drink|
  ba.drinks << Drink.create(name: drink)
  ba.save
  bb.drinks << Drink.create(name: drink)
  bb.save
}


Customer.create(name: "Emma")
Customer.create(name: "Jack")
Customer.create(name: "Clair")
Customer.create(name: "Tim")
