require "spec_helper"

shared_examples "of mobile subcriber identity detection from a valid mobile network http request" do
  it "is present" do
    expect(subject).to be_present
  end
end
