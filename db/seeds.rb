#users
User.create(username: "kat", email: "kat@home.com", password: "password")
User.create(username: "sky", email: "sky@home.com", password: "password")
User.create(username: "tess", email: "tess@home.com", password: "password")


#pieces
Piece.create(size: "small", price: 50, description: "really cool piece!")
Piece.create(size: "medium", price: 10, description: "really cool piece!")
Piece.create(size: "large", price: 100, description: "really cool piece!")


#categories
Category.create(name: "shoes")
Category.create(name: "bags")
Category.create(name: "jeans")
