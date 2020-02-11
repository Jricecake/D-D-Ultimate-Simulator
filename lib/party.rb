class Party < ActiveRecord::Base
    has_many :characters_party
    has_many :character, through: :characters_party
end