# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(name:"Teste", email:"teste@teste.teste", password:"asdasdasd")
Location.create([
  {
    id: 1,
    name: 'Campus capital'
  },
  {
    id: 2,
    name: 'Campus Bauru'
  },
  {
    id: 3,
    name: 'Campus Ribeirão Preto'
  },
  {
    id: 4,
    name: 'Campus São Carlos'
  },
  {
    id: 5,
    name: 'Campus Leste (EACH)'
  },
  {
    id: 6,
    name: 'Campus Pirassununga'
  },
  {
    id: 7,
    name: 'Campus Lorena'
  }
])

Institution.create([
  {
    id: 1,
    name: 'Instituto de Matemática e Estatística',
    tag: 'IME',
    location_id: 1
  },
  {
    id: 2,
    name: 'Escola Politécnica',
    tag: 'Poli',
    location_id: 1
  },
  {
    id: 3,
    name: 'Instituto de Matemática e Estatística',
    tag: 'IME',
    location_id: 1
  },
  {
    id: 4,
    name: 'Faculdade de Economia, Administração e Contabilidade',
    tag: 'FEA',
    location_id: 1
  },
  {
    id: 5,
    name: 'Faculdade de Filosofia, Letras e Ciências Humanas',
    tag: 'FFLCH',
    location_id: 1
  },
  {
    id: 6,
    name: 'Escola de Comunicações e Artes',
    tag: 'ECA',
    location_id: 1
  },
  {
    id: 7,
    name: 'Instituto de Matemática e Estatística',
    tag: 'IME',
    location_id: 1
  },
  {
    id: 8,
    name: 'Instituto de Química',
    tag: 'IQ',
    location_id: 1
  },
  {
    id: 9,
    name: 'Faculdade de Medicina Veterinária e Zootecnia',
    tag: 'FMVZ',
    location_id: 1
  },
  {
    id: 10,
    name: 'Instituto de Biociências',
    tag: 'IB',
    location_id: 1
  },
])

StudyRoom.create([{
    name: 'Sala IME 01',
    institution_id: 1,
    fits_number: 5,
    is_free: true
  },
  {
    name: 'Sala IME 02',
    institution_id: 1,
    fits_number: 5,
    is_free: true
  },
  {
    name: 'Sala IME 03',
    institution_id: 1,
    fits_number: 5,
    is_free: false
  },
  {
    name: 'Sala IME 04',
    institution_id: 1,
    fits_number: 5,
    is_free: false
  },
  {
    name: 'Sala IME 05',
    institution_id: 1,
    fits_number: 10,
    is_free: true
  },
  {
    name: 'Sala IME 06',
    institution_id: 1,
    fits_number: 10,
    is_free: true
  },
  {
    name: 'Elétrica sala 01',
    institution_id: 2,
    fits_number: 4,
    is_free: true
  },
  {
    name: 'Elétrica sala 02',
    institution_id: 2,
    fits_number: 4,
    is_free: true
  },
  {
    name: 'Elétrica sala 03',
    institution_id: 2,
    fits_number: 6,
    is_free: true
  },
  {
    name: 'Elétrica sala 04',
    institution_id: 2,
    fits_number: 6,
    is_free: false
  },
  {
    name: 'FEA Sala 01',
    institution_id: 2,
    fits_number: 8,
    is_free: false
  },
  {
    name: 'FEA Sala 02',
    institution_id: 2,
    fits_number: 4,
    is_free: false
  },
  {
    name: 'FEA Sala 03',
    institution_id: 2,
    fits_number: 4,
    is_free: false
  },
  {
    name: 'FEA Sala 04',
    institution_id: 2,
    fits_number: 4,
    is_free: false
  },
])

LogStudyRoom.create([
  {
    study_room_id: 1,
    taken: true,
    time_of_day: 43200, # 12:00
    created_at: 30.days.ago
  },
  {
    study_room_id: 1,
    taken: false,
    time_of_day: 47200, # 13:06
    created_at: 30.days.ago
  },
  {
    study_room_id: 1,
    taken: true,
    time_of_day: 50000, # 13:06
    created_at: 29.days.ago
  },
  {
    study_room_id: 1,
    taken: false,
    time_of_day: 54230, # 15:05
    created_at: 29.days.ago
  },
])
