require "spec_helper"

describe MobileSubscriber::Detection::FromMsisdnHttpRequestHeader do

  include described_class::ClassMethods

  let :test_request do
    build :mobile_request_from_claro_brasil
  end

  describe "the returned object of self.extract_from_msisdn_http_request_header" do

    subject do
      extract_from_msisdn_http_request_header test_request
    end

    context "when given a request made from Claro Brasil" do
      let(:test_request) { build :mobile_request_from_claro_brasil }

      include_examples "of detection of msisdn from a valid brazilian mobile network http request"

      it "has a :mobile_network_code value of '05' or '38'" do
        expect(subject[:mobile_network_code]).to match /05|38/i
      end
    end

    context "when given a request made from Claro Chile" do
      let(:test_request) { build :mobile_request_from_claro_chile }

      include_examples "of detection of msisdn from a valid chilean mobile network http request"

      it "has a :mobile_network_code value of '03'" do
        expect(subject[:mobile_network_code]).to eq '03'
      end
    end

    context "when given a request made from Claro Colombia" do
      let(:test_request) { build :mobile_request_from_claro_colombia }

      include_examples "of detection of msisdn from a valid colombian mobile network http request"

      it "has a :mobile_network_code value of '101'" do
        expect(subject[:mobile_network_code]).to eq '101'
      end
    end

    context "when given a request made from Claro Ecuador" do
      let(:test_request) { build :mobile_request_from_claro_ecuador }

      include_examples "of detection of msisdn from a valid ecuadorian mobile network http request"

      it "has a :mobile_network_code value of '01'" do
        expect(subject[:mobile_network_code]).to eq '01'
      end
    end
    
  end

end
