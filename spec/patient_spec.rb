require("spec_helper")

describe(Patient) do
  describe(".all") do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a patient to the array of saved patients") do
      patient = Patient.new({:name => 'bingo', :id => nil, :dob => '2000-01-01 00:00:00', :doctor_id => 1})
      patient.save()
      expect(Patient.all()).to(eq([patient]))
    end
  end

  describe("#==") do
    it("is the same patient if it has the same name and date of birth") do
      patient1 = Patient.new({:name => "polly", :id => nil, :dob => '2000-01-01 00:00:00', :doctor_id => 1})
      patient2 = Patient.new({:name => "polly", :id => nil, :dob => '2000-01-01 00:00:00', :doctor_id => 1})
      expect(patient1).to(eq(patient2))
    end
  end
end
