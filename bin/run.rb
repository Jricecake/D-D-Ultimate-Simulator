require_relative '../config/environment'


cli = CommandLineInterface.new

cli.run
cli.menu
cli.create_a_character
cli.form_a_party