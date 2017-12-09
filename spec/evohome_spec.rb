describe Evohome do
  describe "#connect!" do
    it "connects to the Honeywell api and gets a session id" do
      VCR.use_cassette "connect!" do
        email = "mail@example.com"
        password = "password"
        application_id = "abc-123-456-789-1012345"

        evohome = Evohome.new(username: email, password: password, application_id: application_id)
        evohome.connect!

        expect(evohome.sessionid).to eq "C2736E4E-605A-439D-AFB6-B45C32022D05"
      end
    end
  end

  context "with a valid sessionid and user_id" do
    let(:session_id) { "6CB595A4-0BB5-4F2D-B87F-A901EAC32635" }
    let(:user_id) { "1234" }

    describe "#thermostats" do
      it "gets the thermostats data" do
        VCR.use_cassette "thermostats" do
          evohome = Evohome.new
          evohome.sessionid = session_id
          evohome.user_id = user_id

          expect(evohome).to have(9).thermostats
        end
      end
    end
  end
end
