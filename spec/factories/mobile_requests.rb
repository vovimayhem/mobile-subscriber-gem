# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :common_mobile_request_env, class: Hash do
    initialize_with do
      {
        "HTTP_HOST"             =>  "www.example.com",
        "HTTP_CONNECTION"       =>  "close",
        "HTTP_CACHE_CONTROL"    =>  "no-cache, max-age=0",
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
        "REMOTE_ADDR"           =>  "201.144.162.4"
      )
    end
  end

end
