class Category < ApplicationRecord
    has_many :groups
    has_many :products, through: :groups
end
