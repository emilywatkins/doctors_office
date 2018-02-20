class Patient
  attr_reader(:name, :id, :dob, :doctor_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @dob = attributes.fetch(:dob)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  def self.all
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch("name")
      id = patient.fetch("id").to_i()
      dob = patient.fetch("dob")
      doctor_id = patient.fetch("doctor_id").to_i()
      patients.push(Patient.new({:name => name, :id => id, :dob => dob, :doctor_id => doctor_id}))
    end
    patients
  end

  def save
    result = DB.exec("INSERT INTO patients (name, dob, doctor_id) VALUES ('#{@name}', '#{@dob}', #{@doctor_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_patient)
    self.name().==(another_patient.name()).&(self.id().==(another_patient.id())).&(self.dob().==(another_patient.dob()))
  end


end
