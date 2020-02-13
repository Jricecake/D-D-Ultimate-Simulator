class Character < ActiveRecord::Base
    has_many :characters_groups, dependent: :destroy
    has_many :groups, through: :characters_groups

    def self.all_characters
        Character.all.map {|char| "#{char.name} is a level #{char.level} #{char.character_class}"}
    end

    def self.available_chars
        available_chars = Character.all.select{|char| char.number_of_groups == 0}
    end

    def level_up
        current_level = self.level
        if current_level < 20
            self.update_column(:level, current_level+=1) 
        else
            puts "This character is already maxed."
        end
    end

    def join_group(group)
        current_membership = CharactersGroup.where(character_id: self.id).count
        if group.characters.exists?(self.id)
            puts "This character is already in this group!"
        else
        CharactersGroup.create(group_id: group.id, character_id: self.id)
        current_membership += 1
        self.update_column(:number_of_groups, current_membership)
        end
    end

    def add_to_group(group)
        current_membership = CharactersGroup.where(character_id: self.id).count
        CharactersGroup.create(group_id: group.id, character_id: self.id)
        current_membership += 1
        self.update_column(:number_of_groups, current_membership)
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
        current_membership = self.number_of_groups
        self.groups.clear
        self.update_column(:number_of_groups, current_membership)
    end

    def died
        Character.destroy(self.id)
    end

end

