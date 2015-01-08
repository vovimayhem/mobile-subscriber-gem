require "spec_helper"

describe MobileSubscriber::Detection::FromXUpCallingLineIdHttpRequestHeader do

  include described_class

  let :test_request_info do
    MobileSubscriber::Detection::HttpRequestInfo.new test_request.env
  end

  describe "the returned object of self.extract_from_msisdn_http_request_header" do

    subject do
      extract_from_x_up_calling_line_id_http_request_header test_request_info
    end

    context "when given a request made from Claro Perú" do
      let(:test_request) { build :mobile_request_from_claro_peru }

      include_examples "of detection of msisdn from a valid peruvian mobile network http request"

      it "has a :mobile_network_code value of '10'" do
        expect(subject[:mobile_network_code]).to eq '10'
      end
    end

    context "when given a request made from Movistar Perú" do
      let(:test_request) { build :mobile_request_from_movistar_peru }

      include_examples "of detection of msisdn from a valid peruvian mobile network http request"

      it "has a :mobile_network_code value of '06'" do
        expect(subject[:mobile_network_code]).to eq '06'
      end
    end

  end

end
