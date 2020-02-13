require "tty-prompt"

class CommandLineInterface

    @@new_hero = nil
    @@new_party = nil

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
                @@new_hero.join_group(desired_group[0])
                @@new_party = desired_group[0]
                puts "A formidable bunch!\n"
                go_quest
        elsif selection == "Form a Party"
            form_a_party
        end
    end

    def create_a_character
        prompt = TTY::Prompt.new
        @classes_type = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]
        @races = ["Human", "Dragonborn", "Dwarf", "Elf", "Half-Elf", "Gnome", "Halfing", "Half-Orc", "Tiefling"]
        puts "What is your Name:".red
        hero_name = gets.strip
        hero_class = prompt.select("What is your class?".red, @classes_type)
        hero_race = prompt.select("What is your race?".red, @races)
        @@new_hero = Character.create(name: hero_name, character_class: hero_class, race: hero_race)
    end

    def form_a_party
        puts "What do you call your party?"
        party_name = gets.strip
        Group.create(name: party_name)
        @@new_party = Group.all.where(name: party_name)
        @@new_hero.add_to_group(@@new_party[0])
        puts "The people will celebrate #{party_name} for centuries!\n".red
        add_to_party
    end

    def add_to_party
        prompt = TTY::Prompt.new
        binding.pry
        avail_char_hash = view_available_characters.to_h {|char| ["#{char.name} is a level #{char.level} #{char.character_class}", char.id]}
        join_member = prompt.select("Who will you ask to join?", avail_char_hash)
        found_member = Character.all.find{|char| char.id == join_member}
        binding.pry
        found_member.add_to_group(@@new_party[0])
        more_members = prompt.select("Anyone else?", ["Yes", "No", "View Party"])
            if more_members == "Yes"
                add_to_party
            elsif more_members == "No"
                go_quest
            elsif more_members == "View Party"
                # binding.pry
                puts "Your party consists of:\n".red
                Group.last.members
                puts "\n"
                add_to_party
            else
                puts "I don't understand.. Try again!"
            end
    end
    

    def go_quest
        prompt = TTY::Prompt.new
        puts "Your party is ready for adventure! You find your nearest quest and depart!"
        # binding.pry
        chance = rand(1...10)
        # binding.pry
        if chance == 6
            @@new_party[0].die
            puts "Oh no! It seems your party was eaten by a dragon! You're all dead and no one remembers you. You die slowly, painfully, and without purpose. As you the last few drops of blood seep from your wounds, you glance over and see the rest of your party, resenting you for your idea to come here in the first place.".red
            prompt = TTY::Prompt.new
            choice = prompt.select("Restart?", %w(Yes No))
            if choice == "Yes"
                run
            elsif choice == "No"
                exit
            end
        else 
            @@new_party[0].return_from_quest
            puts "Wow, you really did it! Good job!"
            drink = prompt.select("Do you celebrate, or continue on to your next quest?", %w(Celebrate Quest))
            if drink == "Celebrate"
                tavern_time
            elsif drink == "Quest"
                go_quest
            end
        end

    end



    def tavern_time
        prompt = TTY::Prompt.new
        @drink_count = 1
        puts "You approach a bustling tavern. Heads turn as commoners recognize the victorious. Your party sits and drinks to good health and fortune!"
        drinks = prompt.select("Another round?", %w(Yes! No))
        if drinks == "Yes!"
            take_drink
        elsif drinks == "No"
            puts "You decide you have celebrated enough and prepare for your next adventure.\n"
            go_quest
        end
    end

    def take_drink
        if @drink_count < 10
        @drink_count += 1
        puts "A frothy ale appears in front of you. You drink it down and feel just that much better!"
        else
            puts "Your vision began fading a few drinks ago. At this point, you have no control over your body. Collapsing outside of the bar, you are recognized by a common thief as a decorated adventurer. He robs you of all your valuables. When you come to, you realize that not only have you lost your possessions, but everyone's respect as well. Unable to recover from this, you slowly succumb to alcoholism, eventually perishing from asphyxiation from vomitting in your sleep.".red
            @@new_hero.die
            restart
        end
    end

    def view_available_characters
        Character.available_chars
    end

    def view_parties
        # binding.pry
        Group.all.map {|group| group.name}
    end


end