# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_list = [
  ["M01", "Admin", "Son", "Che", "admin@gmail.com", "12345678", "12345678"],
  ["M02", "", "Son", "Che Dinh", "sonchedinh@gmail.com", "12345678", "12345678",1],
  ["M03", "", "Anh", "Le Duc", "leducanh@gmail.com", "12345678", "12345678",1],
  ["M04", "", "Quy", "Nguyen Tien", "nguyentienquy@gmail.com", "12345678", "12345678"]
]
user_list.each do |user|
  User.create(code: user[0], type: user[1], first_name: user[2], last_name: user[3], 
    email: user[4], password: user[5], password_confirmation: user[6], current_big_farm_id: user[7] )
end

task_list = [
  ["Demo 1", "Task from file seed", "Task demo", 1, 1, 1, "Self", "Open", 0],
  ["Demo 2", "Task from file seed", "Task demo", 1, 1, 1, "Self", "Open", 0],
  ["Demo 3", "Task from file seed", "Task demo", 1, 1, 3, "Self", "Open", 0],
  ["Demo 4", "Task from file seed", "Task demo", 1, 1, 3, "Self", "Open", 0],
  ["Demo 5", "Task from file seed", "Task demo", 1, 1, 4, "Self", "Open", 0],
  ["Demo 6", "Task from file seed", "Task demo", 1, 1, 4, "Self", "Open", 0]
]
task_list.each do |task|
  Task.create(name: task[0], short_description: task[1], description: task[2], 
  	estimated_time: task[3], taskmaster_id: task[4], assignee_id: task[5], 
  	kind: task[6], status: task[7], process: task[8] )
end

farm_list = [
  ["Big farm test", "Big farm from file seed", 1, 1, ],
  ["Farm Demo 2", "Farm from file seed", 1, 2, 1, 1]
]
farm_list.each do |farm|
  Farm.create(name: farm[0], description: farm[1], user_id: farm[2], kind: farm[3], parent_farm_id: farm[4], big_farm_id: farm[5] )
end

PositionInFarm.create(user_id: 2, farm_id: 1, position: 1, farm_request: 1, big_farm_id: 1)
PositionInFarm.create(user_id: 2, farm_id: 2, position: 1, big_farm_id: 1)