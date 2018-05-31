# MVP = Minimum Viable Product

My app is a clothing piece tracker for a (feminine - how can we make this more queer friendly?) wardrobe that helps the user create and keep track of their wardrobe capsule.

# User Stories

As a user I can...
- see my pieces
- see my categories
- edit my pieces
- create a piece
- delete a piece


# Models & Association


#### User ####

# Attributes
- username
- email
- password

# Associations
- has many pieces
- has many categories through pieces


#### Piece #####

# Attributes
- size
- price
- description
- user_id
- category_id

#Associations
- belongs to user
- has one categories




#### Category #####
# Attributes
- Category (shoes, bags, jeans, trousers, blazers, dresses, skirts, t-shirts, blouses, button-down, coats, sweaters)
  - Can add? can delete?


# Associations
- has many pieces
