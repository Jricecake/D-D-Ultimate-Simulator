class Group < ActiveRecord::Base
    has_many :characters_groups, dependent: :destroy
    has_many :characters, through: :characters_groups

    
    def status
        if self.out_on_quest == true
            puts "The group is out on a quest!"
        else
            puts "This group is ready for a new quest!"
        end
    end

    def adventure
        if self.out_on_quest == false
        self.update(out_on_quest: true)
        else
            puts "This party is already out on a quest!"
        end
    end

    def return_from_quest
        if self.out_on_quest == true
        self.update(out_on_quest: false)
        self.characters.each do |char|
            current_exp = char.exp
            char.update(exp: current_exp += 200)
        end
        puts "Welcome back, heroes!"
        else
            puts "This group is not out on a quest"
        end
    end

    def member_names
        self.characters.all.map {|member| member.name}
    end

    def die
        CharactersGroup.where(group_id: self.id).destroy_all
        self.characters.each {|char| char.destroy}
    end

end


