require "spec_helper"

describe "Telcel HTTP subscriber identity detection" do

  subject do
    MobileSubscriber::Identity.new_from_request test_request
  end

  context "from México" do
    let(:test_request) { build :mobile_request_from_telcel_mexico }

    include_examples "of mobile subcriber identity detection from a valid mexican mobile network http request"

    it "the mobile network code is '020'" do
      expect(subject.mobile_network_code).to eq '020'
    end
  end

end
