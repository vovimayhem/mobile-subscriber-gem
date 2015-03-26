# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  # http://myip.ms/view/ip_owners/7424/Telefonica_Del_Peru_Saa.html
  factory :mobile_request_from_movistar_peru, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR"               => "190.42.165.87",
        "HTTP_X_UP_CALLING_LINE_ID" => "5112100000"
      )
    end
  end

end
