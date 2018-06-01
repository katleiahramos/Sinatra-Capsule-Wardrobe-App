class User < ActiveRecord::Base
has_many :pieces
has_many :categories, through: :pieces
has_one :capsule


has_secure_password


end
