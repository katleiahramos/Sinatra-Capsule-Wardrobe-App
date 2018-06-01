class User < ActiveRecord::Base
has_many :pieces
has_many :categories, through: :pieces
has_many :capsules


has_secure_password


end
