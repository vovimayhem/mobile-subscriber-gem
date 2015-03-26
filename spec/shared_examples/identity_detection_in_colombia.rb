require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid colombian mobile network http request" do
  
  it "the msisdn starts with '57'" do
    expect(subject.msisdn).to start_with '57'
  end

  it "the mobile country code is '732'" do
    expect(subject.mobile_country_code).to eq '732'
  end
end
