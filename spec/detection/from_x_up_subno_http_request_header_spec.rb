require "spec_helper"

describe MobileSubscriber::Detection::FromXUpSubnoHttpRequestHeader do

  include described_class

  let :test_request do
    build :mobile_request_from_claro_colombia
  end

  let :test_request_info do
    MobileSubscriber::Detection::HttpRequestInfo.new test_request.env
  end

  describe "the returned object of self.extract_from_msisdn_http_request_header" do

    subject do
      extract_from_x_up_subno_http_request_header test_request_info
    end

    context "when given a request made from Claro Colombia" do

      include_examples "of detection of msisdn from a valid colombian mobile network http request"

      it "has a :mobile_network_code value of '101'" do
        expect(subject[:mobile_network_code]).to eq '101'
      end
    end

  end

end
