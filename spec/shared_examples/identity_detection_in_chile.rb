require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid chilean mobile network http request" do
  
  it "the msisdn starts with '56'" do
    expect(subject.msisdn).to start_with '56'
  end

  it "the mobile country code is '730'" do
    expect(subject.mobile_country_code).to eq '730'
  end
end
