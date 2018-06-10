# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(name:"Teste", email:"teste@teste.teste", password:"asdasdasd")
Location.create([{
    id: 1,
    name: 'Campus capital'
  },
])

Institution.create([{
  id: 1,
  name: 'Instituto de matemática e estatística',
  location_id: 1
}
])

StudyRoom.create([{
  name: 'Sala IME 01',
  institution_id: 1,
  fits_number: 5,
  is_free: true
}])
