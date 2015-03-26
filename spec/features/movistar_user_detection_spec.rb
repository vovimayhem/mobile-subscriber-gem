require "spec_helper"

describe "Movistar HTTP subscriber identity detection" do

  subject do
    MobileSubscriber::Identity.new_from_request test_request
  end

  context "from Perú" do
    let(:test_request) { build :mobile_request_from_movistar_peru }

    include_examples "of mobile subcriber identity detection from a valid peruvian mobile network http request"

    it "the mobile network code is '06'" do
      expect(subject.mobile_network_code).to eq '06'
    end
  end

end
