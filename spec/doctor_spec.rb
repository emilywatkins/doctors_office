require("spec_helper")

describe(Doctor) do
  describe(".all") do
    it("starts off with no doctors") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save doctors to the database") do
      doctor = Doctor.new({:name => "Dr. A", :id => nil, :specialty => "general medicine"})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe("#==") do
    it("is the same doctor if it has the same name and specialty") do
      doctor1 = Doctor.new({:name => "Dr. A", :id => nil, :specialty => "general medicine"})
      doctor2 = Doctor.new({:name => "Dr. A", :id => nil, :specialty => "general medicine"})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      doctor = Doctor.new({:name => "Dr. A", :id => nil, :specialty => "general medicine"})
      doctor.save()
      expect(doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".find") do
    it("returns a doctor by its ID") do
      doctor = Doctor.new({:name => "Dr. A", :id => nil, :specialty => "general medicine"})
      doctor.save()
      doctor2 = Doctor.new({:name => "Dr. B", :id => nil, :specialty => "general medicine"})
      doctor2.save()
      expect(Doctor.find(doctor2.id())).to(eq(doctor2))
    end
  end

  describe("#patients") do
    it("returns an array of patients for that doctor") do
      doctor = Doctor.new({:name => "Dr. A", :id => nil, :specialty => "general medicine"})
      doctor.save()
      patient = Patient.new({:name => "patient A", :id => nil, :dob => '2000-01-01 00:00:00', :doctor_id => doctor.id()})
      patient.save()
      patient2 = Patient.new({:name => "patient B", :id => nil, :dob => '2000-01-02 00:00:00', :doctor_id => doctor.id()})
      patient2.save()
      expect(doctor.patients()).to(eq([patient, patient2]))
    end
  end
end
