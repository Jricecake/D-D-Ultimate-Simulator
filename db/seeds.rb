10.times do
class_types = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]
races = ["Human", "Dragonborn", "Dwarf", "Elf", "Half-Elf", "Gnome", "Halfing", "Half-Orc", "Tiefling"]

Character.create(name: Faker::FunnyName.name, level: 1, exp: 0, character_class: class_types.sample, race: races.sample, number_of_groups: 0, creator: Faker::FunnyName.name)
end
soundarya = Character.create(name: "Soundarya", level: 15, exp:9000, character_class: "Programming Master", race: "Demigod")
hal = Character.create(name: "Hal", level: 15, exp:9000, character_class: "Ruby Wizard", race: "Demigod")
lucy = Character.create(name: "Lucy", level: 15, exp:9000, character_class: "Code Sorceress", race: "Demigod")

gundrens = Group.create(name: "Gundren's Dreamboats")
fotr = Group.create(name: "Fellowship of the Ring")
bsc = Group.create(name: "Black Spider Clan")
bom = Group.create(name: "Band of Minstrels")
flatiron = Group.create(name: "Seattle012720")
flatiron.characters << soundarya
flatiron.characters << hal
flatiron.characters << lucy


