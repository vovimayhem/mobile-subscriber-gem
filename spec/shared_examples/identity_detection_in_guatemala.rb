require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid guatemalan mobile network http request" do

  

  it "the msisdn starts with '502'" do
    expect(subject.msisdn).to start_with '502'
  end

  it "the mobile country code is '704'" do
    expect(subject.mobile_country_code).to eq '704'
  end
  
end
