# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def rand_in_range(from, to)
	rand * (to - from) + from
end

def rand_time from = 5.years.ago, to = Time.now
	Time.at(rand_in_range(from.to_f, to.to_f))
end

Theme.create([
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
]);

themes = Theme.all

100.times do |n|
	theme = themes.sample
	Question.create({
		content: "Question #{n} du theme \"#{theme.name}\"",
		theme: theme
	})
end

questions = Question.all

500.times do
	Article.create({
		content: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
		question: questions.sample,
		created_at: rand_time,
		tags: 'tag1, tag2, tag3'
	})
end
