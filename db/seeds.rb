10.times do
class_types = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]

Character.create(name: Faker::FunnyName.name, level: 1, exp: 0, character_class: class_types.sample, race: "Human", creator: Faker::FunnyName.name)
end

Party.create(name: "Gundren's Dreamboats")
Party.create(name: "Fellowship of the Ring")
Party.create(name: "Black Spider Clan")
Party.create(name: "Band of Minstrels")
