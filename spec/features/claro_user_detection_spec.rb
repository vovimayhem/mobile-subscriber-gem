require "spec_helper"

describe "Claro HTTP subscriber identity detection" do

  subject do
    MobileSubscriber::Identity.new_from_request test_request
  end

  context "from Argentina" do

    let :test_request do
      build :mobile_request_from_claro_argentina
    end

    include_examples "of mobile subcriber identity detection from a valid argentinian mobile network http request"

    # TODO: Bad test... we need to test for each network code, if it can be determined:
    it "the mobile network code is '310', '320', or '330'" do
      expect(%w(310 320 330)).to include subject.mobile_network_code
    end
  end

  context "from Brasil" do
    let :test_request do
      build :mobile_request_from_claro_brasil
    end

    include_examples "of mobile subcriber identity detection from a valid brazilian mobile network http request"

    it "the mobile network code is '05' or '38'" do
      expect(%w(05 38)).to include subject.mobile_network_code
    end
  end

  context "from Colombia" do

    let(:test_request) { build :mobile_request_from_claro_colombia }

    include_examples "of mobile subcriber identity detection from a valid colombian mobile network http request"

    it "the mobile network code is '101'" do
      expect(subject.mobile_network_code).to eq '101'
    end
  end

  context "from Panamá" do

    let(:test_request) { build :mobile_request_from_claro_panama }

    include_examples "of mobile subcriber identity detection from a valid panamanian mobile network http request"

    it "the mobile network code is '03'" do
      expect(subject.mobile_network_code).to eq '03'
    end
  end

  context "from Ecuador" do
    let(:test_request) { build :mobile_request_from_claro_ecuador }

    include_examples "of mobile subcriber identity detection from a valid ecuadorian mobile network http request"

    it "the mobile network code is '01'" do
      expect(subject.mobile_network_code).to eq '01'
    end
  end

  context "from República Dominicana" do
    let(:test_request) { build :mobile_request_from_claro_dominican_republic }

    include_examples "of mobile subcriber identity detection from a valid dominican mobile network http request"

    it "the mobile network code is '02'" do
      expect(subject.mobile_network_code).to eq '02'
    end
  end

  context "from Argentina" do
    let(:test_request) { build :mobile_request_from_claro_argentina }

    include_examples "of mobile subcriber identity detection from a valid argentinian mobile network http request"

    # TODO: Bad test... we need to test for each network code, if it can be determined:
    it "the mobile network code is '310', '320', or '330'" do
      expect(subject.mobile_network_code).to match /310|320|330/
    end
  end

  context "from Costa Rica" do
    let(:test_request) { build :mobile_request_from_claro_costa_rica }

    include_examples "of mobile subcriber identity detection from a valid costa rican mobile network http request"

    it "the mobile network code is '03'" do
      expect(subject.mobile_network_code).to eq '03'
    end
  end

  context "from Puerto Rico" do
    let(:test_request) { build :mobile_request_from_claro_puerto_rico }

    include_examples "of mobile subcriber identity detection from a valid puerto rican mobile network http request"

    it "the mobile network code is '110'" do
      expect(subject.mobile_network_code).to eq '110'
    end
  end

  context "from Chile" do
    let :test_request do
      build :mobile_request_from_claro_chile
    end

    include_examples "of mobile subcriber identity detection from a valid chilean mobile network http request"

    it "the mobile network code is '03'" do
      expect(subject.mobile_network_code).to eq '03'
    end
  end

  context "from Guatemala" do
    let(:test_request) { build :mobile_request_from_claro_guatemala }

    include_examples "of mobile subcriber identity detection from a valid guatemalan mobile network http request"

    it "the mobile network code is '01'" do
      expect(subject.mobile_network_code).to eq '01'
    end
  end

  context "from Honduras" do
    let(:test_request) { build :mobile_request_from_claro_honduras }

    include_examples "of mobile subcriber identity detection from a valid honduran mobile network http request"

    it "the mobile network code is '001'" do
      expect(subject.mobile_network_code).to eq '001'
    end
  end

  context "from Nicaragua" do
    let(:test_request) { build :mobile_request_from_claro_nicaragua }

    include_examples "of mobile subcriber identity detection from a valid nicaraguan mobile network http request"

    it "the mobile network code is '21'" do
      expect(subject.mobile_network_code).to eq '21'
    end
  end

  context "from El Salvador" do
    let(:test_request) { build :mobile_request_from_claro_el_salvador }

    include_examples "of mobile subcriber identity detection from a valid salvadoran mobile network http request"

    it "the mobile network code is '01'" do
      expect(subject.mobile_network_code).to eq '01'
    end
  end

  context "from Perú" do
    let(:test_request) { build :mobile_request_from_claro_peru }

    include_examples "of mobile subcriber identity detection from a valid peruvian mobile network http request"

    it "the mobile network code is '10'" do
      expect(subject.mobile_network_code).to eq '10'
    end
  end

end
