require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid brazilian mobile network http request" do
  
  it "the msisdn starts with '55'" do
    expect(subject.msisdn).to start_with '55'
  end

  it "the mobile country code is '724'" do
    expect(subject.mobile_country_code).to eq '724'
  end
end
