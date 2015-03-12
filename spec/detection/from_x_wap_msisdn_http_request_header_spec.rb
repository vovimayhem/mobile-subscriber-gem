require "spec_helper"

describe MobileSubscriber::Detection::FromXWapMsisdnHttpRequestHeader do

  include described_class

  let :test_request do
    build :mobile_request_from_claro_chile
  end

  let :test_request_info do
    MobileSubscriber::Detection::HttpRequestInfo.new test_request.env
  end

  describe "the returned object of self.extract_from_msisdn_http_request_header" do

    subject do
      extract_from_x_wap_msisdn_http_request_header test_request_info
    end

    context "when given a request made from Claro Chile" do

      include_examples "of detection of msisdn from a valid chilean mobile network http request"

      it "has a :mobile_network_code value of '03'" do
        expect(subject[:mobile_network_code]).to eq '03'
      end
    end

  end

end
