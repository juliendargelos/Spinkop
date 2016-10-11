# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

themes = Theme.create([
	{
		name: 'Communication',
		color: '#5597ba',
		picture: File.new("#{Rails.root}/db/seed-files/theme-communication.jpg")
	},
	{
		name: 'Innovation et technique',
		color: '#d16c92',
		picture: File.new("#{Rails.root}/db/seed-files/theme-innovation.jpg")
	},
	{
		name: 'Pouvoir et politique',
		color: '#53c18a',
		picture: File.new("#{Rails.root}/db/seed-files/theme-political.jpg")
	},
	{
		name: 'Culture',
		color: '#db9957',
		picture: File.new("#{Rails.root}/db/seed-files/theme-culture.jpg")
	},
	{
		name: 'Jeux',
		color: '#6e88d1',
		picture: File.new("#{Rails.root}/db/seed-files/theme-games.jpg")
	},
	{
		name: 'Sport',
		color: '#d1595c',
		picture: File.new("#{Rails.root}/db/seed-files/theme-sport.jpg")
	},
	{
		name: 'Santé',
		color: '#75c756',
		picture: File.new("#{Rails.root}/db/seed-files/theme-medical.jpg")
	},
	{
		name: 'Espace et temps',
		color: '#4e6c85',
		picture: File.new("#{Rails.root}/db/seed-files/theme-space.jpg")
	},
	{
		name: 'Économie',
		color: '#72d4d0',
		picture: File.new("#{Rails.root}/db/seed-files/theme-money.jpg")
	}
])
