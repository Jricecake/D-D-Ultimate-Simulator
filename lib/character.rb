class Character < ActiveRecord::Base
    has_many :characters_party
    has_many :party, through: :characters_party
end