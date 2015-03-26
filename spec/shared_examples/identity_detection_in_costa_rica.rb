require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid costa rican mobile network http request" do

  

  it "the msisdn starts with '506'" do
    expect(subject.msisdn).to start_with '506'
  end

  it "the mobile country code is '712'" do
    expect(subject.mobile_country_code).to eq '712'
  end

end
