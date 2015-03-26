require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid nicaraguan mobile network http request" do
  
  it "the msisdn starts with '505'" do
    expect(subject.msisdn).to start_with '505'
  end

  it "the mobile country code is '710'" do
    expect(subject.mobile_country_code).to eq '710'
  end
end
