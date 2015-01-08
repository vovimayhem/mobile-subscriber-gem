require "spec_helper"

describe MobileSubscriber::Detection::FromXNokiaMsisdnHttpRequestHeader do

  include described_class

  let :test_request_info do
    MobileSubscriber::Detection::HttpRequestInfo.new test_request.env
  end

  describe "the returned object of self.extract_from_msisdn_http_request_header" do

    subject do
      extract_from_x_nokia_msisdn_http_request_header test_request_info
    end

    context "when given a request made from Telcel México" do
      let(:test_request) { build :mobile_request_from_telcel_mexico }

      include_examples "of detection of msisdn from a valid mexican mobile network http request"

      it "has a :mobile_network_code value of '020'" do
        expect(subject[:mobile_network_code]).to eq '020'
      end
    end

    context "when given a request made from Claro Argentina" do
      let(:test_request) { build :mobile_request_from_claro_argentina }

      include_examples "of detection of msisdn from a valid argentinian mobile network http request"

      # TODO: Bad test... we need to test for each network code, if it can be determined:
      it "has a :mobile_network_code value of '310', '320', or '330'" do
        expect(subject[:mobile_network_code]).to match /310|320|330/
      end
    end
  end

end
