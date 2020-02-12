class Character < ActiveRecord::Base
    has_many :characters_groups
    has_many :groups, through: :characters_groups

    def level_up
        
    end

    def join_group(group)
        current_membership = self.number_of_groups
        if group.characters.exists?(self.id)
            puts "This character is already in this group!"
        else
        CharactersGroup.create(group_id: group.id, character_id: self.id)
        current_membership += 1
        self.update_column(:number_of_groups, current_membership)
        end
    end

    def leave_group(group)
        current_membership = self.number_of_groups
        aras = CharactersGroup.where(group_id: group.id, character_id: self.id)
        if aras
            aras.first.destroy
            current_membership -= 1
            self.update_column(:number_of_groups, current_membership)
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