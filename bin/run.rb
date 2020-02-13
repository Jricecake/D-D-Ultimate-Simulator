require_relative '../config/environment'

@@new_hero = nil
cli = CommandLineInterface.new

cli.run
cli.create_a_character
cli.party_choice
# cli.create_a_character
# cli.form_a_party
