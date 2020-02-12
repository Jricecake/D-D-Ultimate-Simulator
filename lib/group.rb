class Group < ActiveRecord::Base
    has_many :characters_groups
    has_many :characters, through: :characters_groups

    def members
        # binding.pry
        self.characters.all.map {|member| member.name}
    end
end