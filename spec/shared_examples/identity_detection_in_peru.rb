require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid peruvian mobile network http request" do
  
  it "the msisdn starts with '51'" do
    expect(subject.msisdn).to start_with '51'
  end

  it "the mobile country code is '716'" do
    expect(subject.mobile_country_code).to eq '716'
  end
end
