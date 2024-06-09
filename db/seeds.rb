Admin.create(email: 'admin@mail.com', phone: '1234567890', password: 'test123', password_confirmation: 'test123')

Category.create(name: 'Pediatricians')
Category.create(name: 'Allergists')
Category.create(name: 'Dermatologists')
Category.create(name: 'Ophthalmologists')
Category.create(name: 'Cardiologists')

10.times do
  Doctor.create(email: Faker::Internet.email,
                phone: Faker::Number.number(digits: 10).to_s,
                category_id: Faker::Number.within(range: 1..5),
                password: '123456', password_confirmation: '123456')
end

15.times do
  Patient.create(email: Faker::Internet.email,
                 phone: Faker::Number.number(digits: 10).to_s,
                 password: '123456', password_confirmation: '123456')
end
