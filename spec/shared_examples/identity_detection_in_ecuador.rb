require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid ecuadorian mobile network http request" do
  
  it "the msisdn starts with '593'" do
    expect(subject.msisdn).to start_with '593'
  end

  it "the mobile country code is '740'" do
    expect(subject.mobile_country_code).to eq '740'
  end
end
