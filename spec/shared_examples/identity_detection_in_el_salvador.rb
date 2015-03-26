require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid salvadoran mobile network http request" do

  

  it "the msisdn starts with '503'" do
    expect(subject.msisdn).to start_with '503'
  end

  it "the mobile country code is '706'" do
    expect(subject.mobile_country_code).to eq '706'
  end

end
