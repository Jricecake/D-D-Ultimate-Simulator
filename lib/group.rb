class Group < ActiveRecord::Base
    has_many :characters_groups
    has_many :characters, through: :characters_groups

    def members
        
    end
end