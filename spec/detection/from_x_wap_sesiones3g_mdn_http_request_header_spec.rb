require "spec_helper"

describe MobileSubscriber::Detection::FromXWapSesiones3gMdnHttpRequestHeader do

  include described_class

  let :test_request_info do
    MobileSubscriber::Detection::HttpRequestInfo.new test_request.env
  end

  describe "the returned object of self.extract_from_msisdn_http_request_header" do

    subject do
      extract_from_x_wap_sesiones3g_mdn_http_request_header test_request_info
    end

    context "when given a request made from Iusacell Mexico" do
      let(:test_request) { build :mobile_request_from_iusacell_mexico }

      include_examples "of detection of msisdn from a valid mexican mobile network http request"

      it "has a :mobile_network_code value of '040' or '050'" do
        expect(subject[:mobile_network_code]).to match /040|050/i
      end
    end

  end

end
