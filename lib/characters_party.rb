class CharactersParty < ActiveRecord::Base
    belongs_to :character
    belongs_to :party
end