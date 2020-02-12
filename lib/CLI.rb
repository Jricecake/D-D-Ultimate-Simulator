class CommandLineInterface
    @@new_group = nil

    @@classes_type = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]
    @races = ["Human", "Dragonborn", "Dwarf", "Elf", "Half-Elf", "Gnome", "Halfing", "Half-Orc", "Tiefling"]

    def run
        puts "Greetings, Traveler! Could'st thou be in search of excitement and adventure?".red
        puts "Choose your option wisely...glory awaits!".colorize(:light_red)
    end

    def menu
        puts "Choose from the following:".yellow
        puts "1) Create a Character"
        puts "2) Form a Party"
        puts "3) View Other Characters"
        puts "4) View Other Parties"
        puts "5) Go on a quest!"
    end

    def create_a_character
        @classes_type = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]
        @races = ["Human", "Dragonborn", "Dwarf", "Elf", "Half-Elf", "Gnome", "Halfing", "Half-Orc", "Tiefling"]
        puts "Name your Hero:".red
        hero_name = gets.strip
        puts "What Class is your hero?".red
        @classes_type.each {|ctype| puts ctype}
        hero_class = gets.strip
        puts "What Race is your hero?".red
        @races.each {|race| puts race}
        hero_race = gets.strip
        @@new_hero = Character.create(name: hero_name, character_class: hero_class, race: hero_race)
        if @@new_group
            @@new_group.characters << @@new_hero
        end
    end

    def form_a_party
        puts "What do you call your party?"
        party_name = gets.strip
        @@new_group = Group.create(name: party_name)
        binding.pry
        if @@new_hero
        @@new_group.characters << @@new_hero
        end
    end

    def view_other_characters

    end

    def view_parties

    end


end