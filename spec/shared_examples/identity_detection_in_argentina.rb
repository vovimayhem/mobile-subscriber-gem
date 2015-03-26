require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid argentinian mobile network http request" do

  it "the msisdn starts with '54'" do
    expect(subject.msisdn).to start_with '54'
  end
  it "the mobile country code is '722'" do
    expect(subject.mobile_country_code).to eq '722'
  end
end
