# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create Users
10.times do |n|
  email = "lauren@lauren.com" if n.zero?
  email = Faker::Internet.email unless n.zero?
  User.create(
    email: email,
    password: "password"
  )
  puts "Creater User ##{User.last.id}, email: #{User.last.email}"
end

## Create Links
valid_urls = [
  "https://mail.google.com",
  "https://en.todoist.com",
  "https://calendar.google.com",
  "https://drive.google.com",
  "http://backend.turing.io/module4/",
  "https://github.com",
  "http://ruby-doc.org/",
  "https://turing.skedda.com",
  "https://www.fabricationgem.org/",
  "http://getbootstrap.com/getting-started/",
  "http://ncase.me/polygons/",
  "https://turing-fridays.firebaseapp.com/",
  "https://apidock.com/ruby/DateTime/strftime",
  "https://stackoverflow.com/",
  "https://www.codewars.com/dashboard",
  "http://bencrowder.net/files/vim-fu/",
  "http://bigocheatsheet.com/",
  "http://api.jquery.com/",
  "http://www.usatf.org/routes/map/"
]

url_titles = [
  "Gmail",
  "ToDoist",
  "Google Calendar",
  "Google Drive",
  "Turing BE Mod 4 Curriculum",
  "Github",
  "Ruby Docs",
  "Turing Room Scheduler",
  "Fabricator Gem Docs",
  "Bootstrap Getting Started",
  "Parable of Polygons",
  "Turing Fridays",
  "Ruby Stftime Doc",
  "Stack Overflow",
  "Code Wars",
  "Vim Cheat Sheet",
  "Big O Cheat Sheet",
  "JQuery Docs",
  "Run Mapper"
]

## Assign links to users
User.all.each do |user|
  3.times do
    n = rand(0...valid_urls.length)
    Link.create(
      title: url_titles[n],
      url: valid_urls[n],
      user: user
    )
    puts "Added #{Link.last.title} to User #{user.email}"
  end
end
