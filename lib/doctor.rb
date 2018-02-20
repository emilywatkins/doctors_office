class Doctor
  attr_reader(:name, :id, :specialty)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @specialty = attributes.fetch(:specialty)
  end

  def self.all # pushes database values into array for ruby to read
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      id = doctor.fetch("id").to_i()
      specialty = doctor.fetch("specialty")
      doctors.push(Doctor.new({:name => name, :id => id, :specialty => specialty}))
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_doctor)
    self.name().==(another_doctor.name()).&(self.id().==(another_doctor.id())).&(self.specialty().==(another_doctor.specialty()))
  end

  def self.find(id)
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id().==(id)
        found_doctor = doctor
      end
    end
    found_doctor
  end

  def patients
    list_patients = []
    patients = DB.exec("SELECT * FROM patients WHERE doctor_id = #{self.id()};")
    patients.each() do |patient|
      name = patient.fetch("name")
      dob = patient.fetch("dob")
      doctor_id = patient.fetch("doctor_id")
      id = patient.fetch("id").to_i
      list_patients.push(Patient.new({:name => name, :dob => dob, :doctor_id => doctor_id, :id => id}))
    end
    list_patients
  end
end
