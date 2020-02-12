class Character < ActiveRecord::Base
    has_many :characters_groups
    has_many :groups, through: :characters_groups

    def join_group(group)
        if group.characters.exists?(self.id)
            puts "This character is already in this group!"
        else
        CharactersGroup.create(group_id: group.id, character_id: self.id)
        end
    end

    def leave_group(group)
        aras = CharactersGroup.where(group_id: group.id, character_id: self.id)
        # binding.pry
        if aras
            aras.first.destroy
        else
            puts "This character is not in this group."
        end
    end

    def leave_all_groups
        self.groups.clear
    end

    def died
        self.destroy
    end

end