require "spec_helper"

shared_examples "of detection of msisdn from a valid mobile network http request" do
  it "is not nil" do
    expect(subject).not_to be_nil
  end
  it "is not blank" do
    expect(subject).not_to be_blank
  end

  it "has an :id key" do
    expect(subject).to have_key :id
  end
  it "has a non-blank :id value" do
    expect(subject[:id]).not_to be_blank
  end

  it "has an :mobile_country_code key" do
    expect(subject).to have_key :mobile_country_code
  end
  it "has a non-blank :mobile_country_code value" do
    expect(subject[:mobile_country_code]).not_to be_blank
  end

  it "has an :mobile_network_code key" do
    expect(subject).to have_key :mobile_network_code
  end
  it "has a non-blank :mobile_network_code value" do
    expect(subject[:mobile_network_code]).not_to be_blank
  end
end

shared_examples "of detection of msisdn from a valid argentinian mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '54'" do
    expect(subject[:id]).to match /\A54/
  end
  it "has a :mobile_country_code value of '722'" do
    expect(subject[:mobile_country_code]).to eq '722'
  end
end

shared_examples "of detection of msisdn from a valid mexican mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '52'" do
    expect(subject[:id]).to match /\A52/
  end
  it "has a :mobile_country_code value of '334'" do
    expect(subject[:mobile_country_code]).to eq '334'
  end
end

shared_examples "of detection of msisdn from a valid guatemalan mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '502'" do
    expect(subject[:id]).to match /\A502/
  end
  it "has a :mobile_country_code value of '704'" do
    expect(subject[:mobile_country_code]).to eq '704'
  end
end

shared_examples "of detection of msisdn from a valid honduran mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '504'" do
    expect(subject[:id]).to match /\A504/
  end
  it "has a :mobile_country_code value of '708'" do
    expect(subject[:mobile_country_code]).to eq '708'
  end
end

shared_examples "of detection of msisdn from a valid brazilian mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '55'" do
    expect(subject[:id]).to match /\A55/
  end

  it "has a :mobile_country_code value of '724'" do
    expect(subject[:mobile_country_code]).to eq '724'
  end
end

shared_examples "of detection of msisdn from a valid chilean mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '56'" do
    expect(subject[:id]).to match /\A56/
  end

  it "has a :mobile_country_code value of '730'" do
    expect(subject[:mobile_country_code]).to eq '730'
  end
end

shared_examples "of detection of msisdn from a valid costa rican mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '506'" do
    expect(subject[:id]).to match /\A506/
  end

  it "has a :mobile_country_code value of '712'" do
    expect(subject[:mobile_country_code]).to eq '712'
  end
end

shared_examples "of detection of msisdn from a valid colombian mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '57'" do
    expect(subject[:id]).to match /\A57/
  end

  it "has a :mobile_country_code value of '732'" do
    expect(subject[:mobile_country_code]).to eq '732'
  end
end

shared_examples "of detection of msisdn from a valid ecuadorian mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '593'" do
    expect(subject[:id]).to match /\A593/
  end

  it "has a :mobile_country_code value of '740'" do
    expect(subject[:mobile_country_code]).to eq '740'
  end
end

shared_examples "of detection of msisdn from a valid dominican mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '1809'" do
    expect(subject[:id]).to match /\A1809/
  end

  it "has a :mobile_country_code value of '370'" do
    expect(subject[:mobile_country_code]).to eq '370'
  end
end

shared_examples "of detection of msisdn from a valid panamanian mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '507'" do
    expect(subject[:id]).to match /\A507/
  end

  it "has a :mobile_country_code value of '714'" do
    expect(subject[:mobile_country_code]).to eq '714'
  end
end

shared_examples "of detection of msisdn from a valid peruvian mobile network http request" do
  include_examples "of detection of msisdn from a valid mobile network http request"
  it "has an :id value that starts with '51'" do
    expect(subject[:id]).to match /\A51/
  end

  it "has a :mobile_country_code value of '716'" do
    expect(subject[:mobile_country_code]).to eq '716'
  end
end
