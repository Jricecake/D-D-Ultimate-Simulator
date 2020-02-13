require "tty-prompt"

class CommandLineInterface

    @@new_hero = nil
    @@new_party = nil
    @@drink_count = 0

    @@classes_type = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]
    @races = ["Human", "Dragonborn", "Dwarf", "Elf", "Half-Elf", "Gnome", "Halfing", "Half-Orc", "Tiefling"]

    def run
        puts "Greetings, Traveler! Could'st thou be in search of excitement and adventure?".red
        puts "Come...tell me about yourself...glory awaits!".colorize(:light_red)
        create_a_character
    end

    def party_choice
        prompt = TTY::Prompt.new
        selections = ["Form a Party", "Join a Party"]
        puts "Ahhh yes #{@@new_hero.name}.. Glory has never been attained on one's lonesome. You must find a party to adventure with!".red
        selection = prompt.select("Will you join one, or form one?".red, selections)
        if selection == "Join a Party"
            group_selection = prompt.select("Which group will you join?".red, view_parties)
                desired_group = Group.all.find_by(name: group_selection)
                @@new_hero.join_group(desired_group)
                @@new_party = desired_group
                # binding.pry
                puts "A formidable bunch!\n".red
                town_square
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
        town_square
    end

    def form_a_party
        puts "What do you call your party?".red
        party_name = gets.strip
        Group.create(name: party_name)
        @@new_party = Group.all.find_by(name: party_name)
        @@new_hero.add_to_group(@@new_party)
        puts "The people will celebrate #{party_name} for centuries!\n".red
        add_to_party
    end

    def add_to_party
        prompt = TTY::Prompt.new
        # binding.pry
        avail_char_hash = view_available_characters.to_h {|char| ["#{char.name} is a level #{char.level} #{char.character_class}", char.id]}
        join_member = prompt.select("Who will you ask to join?".red, avail_char_hash)
        found_member = Character.all.find{|char| char.id == join_member}
        # binding.pry
        found_member.add_to_group(@@new_party)
        more_members = prompt.select("Anyone else?", ["Yes", "No", "View Party"])
            if more_members == "Yes"
                add_to_party
            elsif more_members == "No"
                town_square
            elsif more_members == "View Party"
                # binding.pry
                puts "Your party consists of:\n".red
                @@new_party.members
                puts "\n"
                add_to_party
            else
                puts "I don't understand.. Try again!".red
            end
    end
    

    def go_quest
        prompt = TTY::Prompt.new
        puts "Your party is ready for adventure! You find your nearest quest and depart!".red
        # binding.pry
        chance = rand(1...10)
        # binding.pry
        if chance == 6
            @@new_party.die
            puts "Oh no! It seems your party was eaten by a dragon! You're all dead and no one remembers you. You die slowly, painfully, and without purpose.\n As you the last few drops of blood seep from your wounds, you glance over and see the rest of your party, resenting you for your idea to come here in the first place.".red
            prompt = TTY::Prompt.new
            choice = prompt.select("Restart?", %w(Yes No))
            if choice == "Yes"
                run
            elsif choice == "No"
                exit
            end
        else 
            @@new_party.return_from_quest
            puts "Wow, you really did it! Good job!".red
            drink = prompt.select("Do you celebrate, or continue on to your next quest?", ["Celebrate", "Prepare for the next quest"])
            if drink == "Celebrate"
                puts "You approach a bustling tavern. Heads turn as commoners recognize the victorious.\n Your party sits and drinks to good health and fortune!".red
                tavern_time
            elsif drink == "Prepare for the next quest"
                town_square
            end
        end
    end

    def tavern_time
        prompt = TTY::Prompt.new
        drinks = prompt.select("You're at the tavern. Have a drink?".red, %w(Yes! No))
        if drinks == "Yes!"
            take_drink
        elsif drinks == "No"
            puts "You decide you have celebrated enough and prepare for your next adventure.\n".red
            town_square
        end
    end

    def take_drink
        prompt = TTY::Prompt.new
        if @@drink_count < 5
        # binding.pry
        puts "A frothy ale appears in front of you. You drink it down and feel just that much better!\n".red
        @@drink_count += 1
        tavern_time
        end
        if @@drink_count >= 5 && @@drink_count < 10
        puts "Wow, you're starting to feel REALLY good! You're having so much fun!\n".red
        @@drink_count += 1
        tavern_time
        end
        if @@drink_count == 10
            puts "Your vision began fading a few drinks ago. At this point, you have no control over your body. Collapsing outside of the bar,\n you are recognized by a common thief as a decorated adventurer. He robs you of all your valuables. When you come to, you realize that not only have you lost your possessions, but everyone's respect as well.\n Unable to recover from this, you slowly succumb to alcoholism, eventually perishing from asphyxiation from vomitting in your sleep.\n \n \n \n".red
            @@new_hero.died
            restart_question = prompt.select("Restart?".red, %w(Yes No))
                if restart_question == "Yes"
                    restart
                elsif restart_question == "No"
                    exit
                end
        end
    end

    def town_square
        prompt = TTY::Prompt.new
        options = ["Meet Companions", "Edit Party", "Go on a Quest", "Go to the Tavern", "Retire"]
        puts "You're in the square"
        do_something = prompt.select("What do you want to do?", options)
            if do_something == "Meet Companions"
                view_available_characters
                town_square
            if do_something == "Edit Party"
                add_to_party
            elsif do_something == "Go on a Quest"
                go_quest
            elsif do_something == "Go to the Tavern"
                tavern_time
            elsif do_something == "Retire"
                puts "You decide that you have had enough of the exciting life.\n You sell your weapons and armor and retire to a small farm on the edge of a forest.\n Long after you perish, people still whisper tales of your heroic efforts.\n\n\n".red
                @@new_hero.died
                restart_question = prompt.select("Restart?".red, %w(Yes No))
                if restart_question == "Yes"
                    restart
                elsif restart_question == "No"
                    exit
                end
            end
        end
    end

    def view_available_characters
        Character.available_chars
    end

    def view_parties
        # binding.pry
        Group.all.map {|group| group.name}
    end

    def restart
        @@new_hero = nil
        @@new_party = nil
        @@drink_count = 0
        run
    end

end