require "spec_helper"

describe MobileSubscriber::ISDN do

  it "responds to #id" do
    expect(subject).to respond_to :id
  end

  it "aliases #id as #to_s" do
    expect(subject.to_s).to eq subject.id
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

  describe "detection from request headers" do

    shared_examples "of detection from a valid request" do
      it "responds to #http_validated? with true" do
        expect(subject).to be_http_validated
      end

      it "responds to #inspect with a string containing '(validated by HTTP)'" do
        expect(subject.inspect).to match /\(validated by HTTP\)>\z/
      end
    end

    shared_examples "of detection from a request made from a mexican mobile network" do
      it "responds to #id with a string starting with '52'" do
        expect(subject.id).to match /\A52/
      end

      it "responds to #mobile_country_code with '334'" do
        expect(subject.mobile_country_code).to eq '334'
      end

      it "responds to #dialing_code with '52'" do
        expect(subject.dialing_code).to eq '52'
      end

      it "responds to #iso_3166_country_code with 'MX'" do
        expect(subject.iso_3166_country_code).to eq 'MX'
      end
    end

    shared_examples "of detection from a request made from an argentinian mobile network" do
      it "responds to #id with a string starting with '54'" do
        expect(subject.id).to match /\A54/
      end

      it "responds to #mobile_country_code with '722'" do
        expect(subject.mobile_country_code).to eq '722'
      end

      it "responds to #dialing_code with '54'" do
        expect(subject.dialing_code).to eq '54'
      end

      it "responds to #iso_3166_country_code with 'AR'" do
        expect(subject.iso_3166_country_code).to eq 'AR'
      end
    end

    shared_examples "of detection from a request made from a brazilian mobile network" do
      it "responds to #id with a string starting with '55'" do
        expect(subject.id).to match /\A55/
      end

      it "responds to #mobile_country_code with '724'" do
        expect(subject.mobile_country_code).to eq '724'
      end

      it "responds to #dialing_code with '55'" do
        expect(subject.dialing_code).to eq '55'
      end

      it "responds to #iso_3166_country_code with 'BR'" do
        expect(subject.iso_3166_country_code).to eq 'BR'
      end
    end

    shared_examples "of detection from a request made from a Claro network" do
      it "responds to #mobile_network_brand with a string containing 'Claro'" do
        expect(subject.mobile_network_brand).to match /\AClaro/
      end
    end

    context "from a request made from Telcel México" do

      subject do
        described_class.new_from_request(build :mobile_request_from_telcel_mexico)
      end

      include_examples "of detection from a valid request"
      include_examples "of detection from a request made from a mexican mobile network"

      it "responds to #mobile_network_brand with 'Telcel'" do
        expect(subject.mobile_network_brand).to eq 'Telcel'
      end

      it "responds to #mobile_network_operator with 'América Móvil'" do
        expect(subject.mobile_network_operator).to eq 'América Móvil'
      end

    end

    context "from a request made from Claro Argentina" do

      subject do
        described_class.new_from_request(build :mobile_request_from_claro_argentina)
      end

      include_examples "of detection from a valid request"
      include_examples "of detection from a request made from an argentinian mobile network"
      include_examples "of detection from a request made from a Claro network"

      it "responds to #mobile_network_operator with 'AMX Argentina S.A.'" do
        expect(subject.mobile_network_operator).to eq 'AMX Argentina S.A.'
      end

    end

    context "from a request made from Claro Brasil" do

      subject do
        described_class.new_from_request(build :mobile_request_from_claro_brasil)
      end

      include_examples "of detection from a valid request"
      include_examples "of detection from a request made from a brazilian mobile network"
      include_examples "of detection from a request made from a Claro network"

      it "responds to #mobile_network_operator with 'Claro'" do
        expect(subject.mobile_network_operator).to eq 'Claro'
      end
    end

  end

end
