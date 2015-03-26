require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid panamanian mobile network http request" do
  
  it "the msisdn starts with '507'" do
    expect(subject.msisdn).to start_with '507'
  end

  it "the mobile country code is '714'" do
    expect(subject.mobile_country_code).to eq '714'
  end
end
