require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid honduran mobile network http request" do
  
  it "the msisdn starts with '504'" do
    expect(subject.msisdn).to start_with '504'
  end
  it "the mobile country code is '708'" do
    expect(subject.mobile_country_code).to eq '708'
  end
end
