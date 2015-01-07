# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :common_mobile_request_env, class: Hash do
    initialize_with do
      {
        "HTTP_HOST"             =>  "www.example.com",
        "HTTP_CONNECTION"       =>  "keep-alive",
        "HTTP_CACHE_CONTROL"    =>  "max-age=0",
        "HTTP_ACCEPT"           =>  "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "HTTP_USER_AGENT"       =>  "Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X; en-us) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53",
        "HTTP_ACCEPT_ENCODING"  =>  "gzip, deflate, sdch",
        "HTTP_ACCEPT_LANGUAGE"  =>  "en-US,en;q=0.8,es;q=0.6",
        "HTTP_VERSION"          =>  "HTTP/1.1"
      }
    end
  end

  factory :mobile_request, class: Rack::Request do

    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR"           =>  "201.144.162.4",
        "REMOTE_HOST"           =>  "201.144.162.4"
      )
    end

    factory :mobile_request_from_telcel_mexico do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"           =>  "201.144.162.4",
          "REMOTE_HOST"           =>  "201.144.162.4",
          "HTTP_X_NOKIA_MSISDN"   =>  "528110000000"
        )
      end
    end

    factory :mobile_request_from_claro_argentina do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"           =>  "170.51.255.240",
          "REMOTE_HOST"           =>  "170.51.255.240",
          "HTTP_X_NOKIA_MSISDN"   =>  "5491141098443"
        )
      end
    end

    factory :mobile_request_from_claro_brasil do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"           =>  "187.26.59.4",
          "REMOTE_HOST"           =>  "187.26.59.4",
          "HTTP_X_UP_CH_MSISDN"   =>  "5500000000000"
        )
      end
    end

    factory :mobile_request_from_claro_peru do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"               => "190.113.192.9",
          "REMOTE_HOST"               => "190.113.192.9",
          "HTTP_X_UP_CALLING_LINE_ID" => "5100000000000",
          "HTTP_VIA"                  => "aa Comverse aaa"
        )
      end
    end


  end
end
