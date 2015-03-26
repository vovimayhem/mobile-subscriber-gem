# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :mobile_request_from_iusacell_mexico, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR"               =>  "201.144.162.4",
        "HTTP_X_WAP_SESIONES3G_MDN" =>  "528110000000"
      )
    end
  end
end
