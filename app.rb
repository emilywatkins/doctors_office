require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/doctor")
require("./lib/patient")
require("pg")

# DB = PG.connect({:dbname => "office"}) #connect to NON-TEST db

DB = PG.connect({:dbname => "office_test"})

get('/') do
  erb(:index)
end

get('/doctors/new') do
  erb(:doctor_form)
end

get('/doctors') do
  @doctors = Doctor.all()
  erb(:doctors)
end

post('/doctors') do
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  doctor = Doctor.new({:name => name, :specialty => specialty, :id => nil})
  doctor.save()
  @doctors = Doctor.all()
  erb(:doctor_success)
end

get('/doctors/:id') do
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
end
