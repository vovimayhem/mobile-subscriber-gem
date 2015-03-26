require "spec_helper"

describe MobileSubscriber::Identity do

  it "responds to #id" do
    expect(subject).to respond_to :id
  end

  it "aliases #id to #to_s" do
    expect(subject.id).to eq subject.to_s
  end

  it "responds to #mobile_country_code" do
    expect(subject).to respond_to :mobile_country_code
  end

  it "responds to #mobile_network_code" do
    expect(subject).to respond_to :mobile_network_code
  end

  it "responds to #dialing_code" do
    expect(subject).to respond_to :dialing_code
  end

  it "responds to #iso_3166_country_code" do
    expect(subject).to respond_to :iso_3166_country_code
  end

  it "responds to #mobile_network_brand" do
    expect(subject).to respond_to :mobile_network_brand
  end

  it "responds to #mobile_network_operator" do
    expect(subject).to respond_to :mobile_network_operator
  end

  it "responds to #http_validated?" do
    expect(subject).to respond_to :http_validated?
  end

  it "responds to #http_request_info" do
    expect(subject).to respond_to :http_request_info
  end

  describe "detection from request headers" do

    context "from a request made from a valid mobile network" do

      subject do
        described_class.new_from_request(build :mobile_request_from_claro_panama)
      end

      it "is not nil" do
        expect(subject).not_to be_nil
      end

      it "responds to #http_validated? with true" do
        expect(subject).to be_http_validated
      end

      it "responds to #inspect with a string containing '(validated by HTTP)'" do
        expect(subject.inspect).to match /\(validated by HTTP\)>\z/
      end

      it "#id is present" do
        expect(subject.msisdn).to be_present
      end

      it "#mobile_country_code is present" do
        expect(subject.mobile_country_code).to be_present
      end

      it "#dialing_code is present" do
        expect(subject.dialing_code).to be_present
      end

      it "#iso_3166_country_code is present" do
        expect(subject.iso_3166_country_code).to be_present
      end

      it "#mobile_network_brand is present" do
        expect(subject.mobile_network_brand).to be_present
      end

      it "#mobile_network_operator is present" do
        expect(subject.mobile_network_operator).to be_present
      end

    end

  end

end
