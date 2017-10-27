# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Create Activites
 activity_list = [
  [ "Part of a Sports Team", "Health & Fitness", 10],
  [ "Run a Half Marathon", "Health & Fitness", 10],
  [ "Run a Marathon", "Health & Fitness", 10],
  [ "Get a Gym Membership", "Health & Fitness", 10],
  [ "Eat 3 Balanced Meals", "Health & Fitness", 10],

  [ "Close with my Siblings", "Relationships & Well-Being", 10],
  [ "Close with my Coworkers", "Relationships & Well-Being", 10],
  [ "Keep in touch with close friends", "Relationships & Well-Being", 10],
  [ "Reflect Regularly", "Relationships & Well-Being", 10],
  [ "Keep Diary & Notes", "Relationships & Well-Being", 10],

  [ "Read a book a month", "Intellectual", 10],
  [ "Read a book a week", "Intellectual", 10],
  [ "Speak 3 Languages", "Intellectual", 10],
  [ "Learn New Skills Regularly", "Intellectual", 10],
  [ "Invest in Development", "Intellectual", 10],

  [ "Written Down Values", "Purpose", 10],
  [ "Clear Long-Term Plan", "Purpose", 10],
  [ "Short Term Goals", "Purpose", 10],
  [ "Medium Term Milestones", "Purpose", 10],
  [ "Invest in Development", "Purpose", 10],

  [ "Attend a conference", "Professional", 10],
  [ "Online Course", "Professional", 10],
  [ "Join Professional Organization", "Professional", 10],
  [ "Identify a Professional Mentor", "Professional", 10],
  [ "Network", "Professional", 10]
]

activity_list.each do |name, category, points|
  Activity.create( name: name, category:category, points:points)
end

  achievement_list = [
    ["5 Fitness", "5 Fitness Activities completed", 'https://goo.gl/GPzS84', "Health & Fitness"],
    ["10 Fitness", "10 Fitness Activities completed", 'https://goo.gl/DxcGK2', "Health & Fitness"],
    ["15 Fitness", "15 Fitness Activities completed", 'https://goo.gl/qwrzDa', "Health & Fitness"],
    ["20 Fitness", "20 Fitness Activities completed", 'https://goo.gl/52dSpG', "Health & Fitness"],
    ["25 Fitness", "25 Fitness Activities completed", 'https://goo.gl/rwF3x8', "Health & Fitness"],

    ["5 Relationship", "5 Relationship & Well-Being Activities completed", 'https://goo.gl/z31uEv', "Relationships & Well-Being"],
    ["10 Relationship", "10 Relationship & Well-Being Activities completed", 'https://goo.gl/h8cmgn', "Relationships & Well-Being"],
    ["15 Relationship", "15 Relationship & Well-Being Activities completed", 'https://goo.gl/VSSFqT', "Relationships & Well-Being"],
    ["20 Relationship", "20 Relationship & Well-Being Activities completed", 'https://goo.gl/Eb5SnX', "Relationships & Well-Being"],
    ["25 Relationship", "25 Relationship & Well-Being Activities completed", 'https://goo.gl/UCi1uf', "Relationships & Well-Being"],

    ["5 Intellectual", "5 Intellectual Activities completed", 'https://goo.gl/7iVeLd', "Intellectual"],
    ["10 Intellectual", "10 Intellectual Activities completed", 'https://goo.gl/dSvTJk', "Intellectual"],
    ["15 Intellectual", "15 Intellectual Activities completed", 'https://goo.gl/G2WsCw', "Intellectual"],
    ["20 Intellectual", "20 Intellectual Activities completed", 'https://goo.gl/QHuNfS', "Intellectual"],
    ["25 Intellectual", "25 Intellectual Activities completed", 'https://goo.gl/7fmssF', "Intellectual"],

    ["5 Purpose", "5 Purpose Activities completed", 'https://goo.gl/nDEtKd', "Purpose"],
    ["10 Purpose", "10 Purpose Activities completed", 'https://goo.gl/4ACwQD', "Purpose"],
    ["15 Purpose", "15 Purpose Activities completed", 'https://goo.gl/yMGMrK', "Purpose"],
    ["20 Purpose", "20 Purpose Activities completed", 'https://goo.gl/HQUWLv', "Purpose"],
    ["25 Purpose", "25 Purpose Activities completed", 'https://goo.gl/KXNmuN', "Purpose"],

    ["5 Professional", "5 Professional Activities completed", 'https://goo.gl/idsa2K', "Professional"],
    ["10 Professional", "10 Professional Activities completed", 'https://goo.gl/LctTwk', "Professional"],
    ["15 Professional", "15 Professional Activities completed", 'https://goo.gl/Pmw11Q', "Professional"],
    ["20 Professional", "20 Professional Activities completed", 'https://goo.gl/oqntoH', "Professional"],
    ["25 Professional", "25 Professional Activities completed", 'https://goo.gl/pYWuJC', "Professional"]

  ]

achievement_list.each do |name, description, img_reference, category|
  Achievement.create( name: name, description:description, img_reference:img_reference, category:category)
end
