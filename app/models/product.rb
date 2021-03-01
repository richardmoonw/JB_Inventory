class Product < ApplicationRecord
    has_many :groups
    has_many :categories, through: :groups
end
