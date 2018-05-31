class Category < ActiveRecord::Base
has_many :pieces
has_many :users, through: :pieces
end
