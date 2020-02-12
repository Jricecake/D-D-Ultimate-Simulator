class CommandLineInterface

    def run
        puts "Greetings, Traveler! Could'st thou be in search of excitement and adventure?".red
        puts "Choose your option wisely...glory may await!".colorize(:light_red)
        puts "Pick from the following:".yellow
        # binding.pry

    end

    def menu
        puts "1) Create a Character"
        puts "2) Form a Party"
        puts "3) View Other Characters"
        puts "4) View Other Parties"
        puts "5) Go on a quest!"

    end

end