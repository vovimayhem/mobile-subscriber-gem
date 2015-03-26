require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid dominican mobile network http request" do
  
  it "the msisdn starts with '1809'" do
    expect(subject.msisdn).to start_with '1809'
  end

  it "the mobile country code is '370'" do
    expect(subject.mobile_country_code).to eq '370'
  end
end
