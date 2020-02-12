class CharactersGroup < ActiveRecord::Base
    belongs_to :character
    belongs_to :group
end