# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Create Activites
 activity_list = [
  [ "Part of a Sports Team", "", "Health & Fitness", 10],
  [ "Run a Half Marathon", "", "Health & Fitness", 10],
  [ "Run a Marathon", "", "Health & Fitness", 10],
  [ "Get a Gym Membership", "", "Health & Fitness", 10],
  [ "Eat 3 Balanced Meals", "", "Health & Fitness", 10],

  [ "Close with my Siblings", "", "Relationships & Well-Being", 10],
  [ "Close with my Coworkers", "", "Relationships & Well-Being", 10],
  [ "Keep in touch with close friends", "", "Relationships & Well-Being", 10],
  [ "Reflect Regularly", "", "Relationships & Well-Being", 10],
  [ "Keep Diary & Notes", "", "Relationships & Well-Being", 10],

  [ "Read a book a month", "", "Intellectual", 10],
  [ "Read a book a week", "", "Intellectual", 10],
  [ "Speak 3 Languages", "", "Intellectual", 10],
  [ "Learn New Skills Regularly", "", "Intellectual", 10],
  [ "Invest in Development", "", "Intellectual", 10],

  [ "Written Down Values", "", "Purpose", 10],
  [ "Clear Long-Term Plan", "", "Purpose", 10],
  [ "Short Term Goals", "", "Purpose", 10],
  [ "Medium Term Milestones", "", "Purpose", 10],
  [ "Invest in Development", "", "Purpose", 10],

  [ "Attend a conference", "", "Professional", 10],
  [ "Online Course", "", "Professional", 10],
  [ "Join Professional Organization", "", "Professional", 10],
  [ "Identify a Professional Mentor", "", "Professional", 10],
  [ "Network", "", "Professional", 10]
]

activity_list.each do |name, description, category, points|
  Activity.create( name: name, description:description, category:category, points:points)
end
