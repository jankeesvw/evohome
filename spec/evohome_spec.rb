describe Evohome do
  describe "connection" do
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
end
