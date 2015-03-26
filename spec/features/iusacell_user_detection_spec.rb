require "spec_helper"

describe "Iusacell HTTP subscriber identity detection" do

  subject do
    MobileSubscriber::Identity.new_from_request test_request
  end

  context "from México" do
    let(:test_request) { build :mobile_request_from_iusacell_mexico }

    include_examples "of mobile subcriber identity detection from a valid mexican mobile network http request"

    it "the mobile network code is '040' or '050'" do
      expect(subject.mobile_network_code).to match /040|050/i
    end
  end

end
