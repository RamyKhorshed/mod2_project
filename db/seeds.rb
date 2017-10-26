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
    ["5 Fitness", "5 Fitness Activities completed", '../../views/images/Red_star.png'],
    ["10 Fitness", "10 Fitness Activities completed", '../../views/images/Orange_star.png'],
    ["15 Fitness", "15 Fitness Activities completed", '../../views/images/Yellow_star.png'],
    ["20 Fitness", "20 Fitness Activities completed", '../../views/images/Green_star.png'],
    ["25 Fitness", "25 Fitness Activities completed", '../../views/images/Blue_star.png'],

    ["5 Relationship", "5 Relationship & Well-Being Activities completed", '../../views/images/Red_star.png'],
    ["10 Relationship", "10 Relationship & Well-Being Activities completed", '../../views/images/Orange_star.png'],
    ["15 Relationship", "15 Relationship & Well-Being Activities completed", '../../views/images/Yellow_star.png'],
    ["20 Relationship", "20 Relationship & Well-Being Activities completed", '../../views/images/Green_star.png'],
    ["25 Relationship", "25 Relationship & Well-Being Activities completed", '../../views/images/Blue_star.png'],

    ["5 Intellectual", "5 Intellectual Activities completed", '../../views/images/Red_star.png'],
    ["10 Intellectual", "10 Intellectual Activities completed", '../../views/images/Orange_star.png'],
    ["15 Intellectual", "15 Intellectual Activities completed", '../../views/images/Yellow_star.png'],
    ["20 Intellectual", "20 Intellectual Activities completed", '../../views/images/Green_star.png'],
    ["25 Intellectual", "25 Intellectual Activities completed", '../../views/images/Blue_star.png'],

    ["5 Purpose", "5 Purpose Activities completed", '../../views/images/Red_star.png'],
    ["10 Purpose", "10 Purpose Activities completed", '../../views/images/Orange_star.png'],
    ["15 Purpose", "15 Purpose Activities completed", '../../views/images/Yellow_star.png'],
    ["20 Purpose", "20 Purpose Activities completed", '../../views/images/Green_star.png'],
    ["25 Purpose", "25 Purpose Activities completed", '../../views/images/Blue_star.png'],

    ["5 Professional", "5 Professional Activities completed", '../../views/images/Red_star.png'],
    ["10 Professional", "10 Professional Activities completed", '../../views/images/Orange_star.png'],
    ["15 Professional", "15 Professional Activities completed", '../../views/images/Yellow_star.png'],
    ["20 Professional", "20 Professional Activities completed", '../../views/images/Green_star.png'],
    ["25 Professional", "25 Professional Activities completed", '../../views/images/Blue_star.png']

  ]

achievement_list.each do |name, description, img_reference|
  Achievement.create( name: name, description:description, img_reference:img_reference)
end
