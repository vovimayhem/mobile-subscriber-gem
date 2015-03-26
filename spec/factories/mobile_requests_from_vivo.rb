# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :mobile_request_from_vivo_brasil, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR"           =>  "187.26.59.4",
        "HTTP_X_UP_CH_MSISDN"   =>  "5500000000000"
      )
    end
  end
end
