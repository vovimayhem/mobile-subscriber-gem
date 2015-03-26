require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid puerto rican mobile network http request" do

  

  it "the msisdn starts with '1'" do
    expect(subject.msisdn).to start_with '1'
  end

  it "the mobile country code is '330'" do
    expect(subject.mobile_country_code).to eq '330'
  end
end
