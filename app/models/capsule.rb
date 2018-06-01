class Capsule < ActiveRecord::Base
belongs_to :user
has_many :pieces
has_many :categories, through: :clothes

end
