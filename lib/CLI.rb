require "tty-prompt"

class CommandLineInterface

    @@new_hero = nil

    @@classes_type = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]
    @races = ["Human", "Dragonborn", "Dwarf", "Elf", "Half-Elf", "Gnome", "Halfing", "Half-Orc", "Tiefling"]

    def run
        puts "Greetings, Traveler! Could'st thou be in search of excitement and adventure?".red
        puts "Come...tell me about yourself...glory awaits!".colorize(:light_red)
    end

    def party_choice
        prompt = TTY::Prompt.new
        selections = ["Join a Party", "Form a Party"]
        puts "Ahhh yes #{@@new_hero.name}.. Glory has never been attained on one's lonesome. You must find a party to adventure with!"
        selection = prompt.select("Will you join one, or form one?", selections)
        if selection == "Join a Party"
            group_selection = prompt.select("Which group will you join?", view_parties)
                desired_group = Group.all.where(name: group_selection)
                # binding.pry
                @@new_hero.join_group(desired_group[0])
                puts "A formidable bunch! "
        elsif selection == "Form a Party"
            form_a_party
        end
    end

    # def menu
    #     prompt = TTY::Prompt.new
    #     selections = ["Create a Character", "Form a Party", "View Other Characters", "View Other Parties", "Go on a quest!", "Quit"]
    #     selection = prompt.select("Choose from the following", selections)
    #     if selection == "Create a Character"
    #         create_a_character
    #     elsif selection == "Form a Party"
    #         form_a_party
    #     elsif selection == "View Other Characters"
    #         view_other_characters
    #     elsif selection == "View Other Parties"
    #         view_parties
    #     elsif selection == "Go on a quest!"
    #         go_quest
    #     elsif selection == "Quit"
    #         exit
    #     else
    #         puts "Invalid entry, you fool! Try again!"
    #         menu
    #     end
    # end

    def create_a_character
        prompt = TTY::Prompt.new
        @classes_type = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]
        @races = ["Human", "Dragonborn", "Dwarf", "Elf", "Half-Elf", "Gnome", "Halfing", "Half-Orc", "Tiefling"]
        puts "What is your Name:".red
        hero_name = gets.strip
        puts "What is your Class?".red
        hero_class = prompt.select("What is your class?".red, @classes_type)
        hero_race = prompt.select("What is your race?".red, @races)
        @@new_hero = Character.create(name: hero_name, character_class: hero_class, race: hero_race)
    end

    def form_a_party
        puts "What do you call your party?"
        party_name = gets.strip
        Group.create(name: party_name)
        new_party = Group.all.where(name: party_name)
        binding.pry
        @@new_hero.add_to_group(new_party[0])
    end

    def view_other_characters
        Character.all_characters
    end

    def view_parties
        # binding.pry
        Group.all.map {|group| group.name}
    end


end