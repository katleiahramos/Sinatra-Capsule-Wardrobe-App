  bags = Category.create(name: "Bags")
  trousers = Category.create(name: "Trousers")
  jeans = Category.create(name: "Jeans")
  tshirts = Category.create(name: "T-shirts")
  coats = Category.create(name: "Coats")
  blazers = Category.create(name: "Blazers")
  shoes = Category.create(name: "Shoes")
  button_downs = Category.create(name: "Button-downs")
  sweaters = Category.create(name: "Sweaters")
  dresses = Category.create(name: "Dresses")
  skirts = Category.create(name: "Skirts")



dress = Piece.create(description: "Grey H&M Dress", price: "15")
dress.category = dresses

bag = Piece.create(description: "Addidas Bag", price: "40")
bag.category = bags

kat = User.create(username: "kat", password: "awesome", email: "kat@home.com")
kat.pieces << dress
kat.pieces << bag
