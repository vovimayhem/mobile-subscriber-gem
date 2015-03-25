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

    factory :mobile_request_from_iusacell_mexico do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"               =>  "201.144.162.4",
          "HTTP_X_WAP_SESIONES3G_MDN" =>  "528110000000"
        )
      end
    end

    factory :mobile_request_from_telcel_mexico do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"           =>  "201.144.162.4",
          "HTTP_X_NOKIA_MSISDN"   =>  "528110000000"
        )
      end
    end

    factory :mobile_request_from_claro_argentina do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"           =>  "170.51.255.240",
          "HTTP_X_NOKIA_MSISDN"   =>  "5491141090000"
        )
      end
    end

    factory :mobile_request_from_claro_brasil do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "201.23.176.202",
          "HTTP_MSISDN" =>  "5500000000000"
        )
      end
    end

    # TODO: Replace with a real example:
    factory :mobile_request_from_claro_dominican_republic do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "181.37.104.3",
          "HTTP_MSISDN" =>  "18098591800"
        )
      end
    end

    # http://ns.myip.ms/view/ip_owners/181034/Claro_Chile_S_a.html
    factory :mobile_request_from_claro_chile do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "191.116.39.114",
          "HTTP_X_WAP_MSISDN" =>  "56024440000"
        )
      end
    end

    factory :mobile_request_from_claro_colombia do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "200.26.137.100",
          "HTTP_X_UP_SUBNO" =>  "57000000000"
        )
      end
    end

    # TODO: Replace with a real example request:
    factory :mobile_request_from_claro_costa_rica do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "186.26.126.37",
          "HTTP_X_NOKIA_MSISDN" =>  "50600000000"
        )
      end
    end

    # TODO: Replace with a real example request:
    factory :mobile_request_from_claro_puerto_rico do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "64.237.130.12",
          "HTTP_X_NOKIA_MSISDN" =>  "17872889401" # 1-787-XXXXXXXX
        )
      end
    end

    # http://myip.ms/view/ip_owners/80612/Conecel.html
    factory :mobile_request_from_claro_ecuador do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "190.63.1.10",
          "HTTP_MSISDN" =>  "59342690000"
        )
      end
    end

    # Request from a client through Claro Guatemala network:
    # (Built from an actual ATP test)
    factory :mobile_request_from_claro_guatemala do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "216.230.152.158",
          "HTTP_X_NOKIA_MSISDN" => "50241865146",
          "HTTP_X_NOKIA_IMSI" => "704012013128442",
          "HTTP_X_FORWARDED_FOR" => "190.212.233.218, 204.0.3.199"
        )
      end
    end

    # TODO: Replace with a real example:
    factory :mobile_request_from_claro_honduras do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "190.107.157.31",
          "HTTP_X_NOKIA_MSISDN" => "50430000000"
        )
      end
    end

    # TODO: Replace with a real example request:
    factory :mobile_request_from_claro_nicaragua do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "190.212.88.8",
          "HTTP_X_NOKIA_MSISDN" =>  "50500000000"
        )
      end
    end

    # TODO: Replace with a real example request:
    factory :mobile_request_from_claro_el_salvador do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR" =>  "190.86.139.225",
          "HTTP_X_NOKIA_MSISDN" =>  "50300000000"
        )
      end
    end

    # Real request recorded at claroapps.com at 2015-03-24
    factory :mobile_request_from_claro_peru do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"             => "216.246.75.208", # This IP belongs to a U.S. datacenter which acts as proxy for the real user...

          "HTTP_ACCEPT_LANGUAGE"    => "es-PE,es-419;q=0.8,es;q=0.6",
          "HTTP_AKAMAI_ORIGIN_HOP"  => "1",
          "HTTP_CONNECT_TIME"       => "3",
          "HTTP_PRAGMA"             => "no-cache",
          "HTTP_TOTAL_ROUTE_TIME"   => "5",
          "HTTP_VERSION"            => "HTTP/1.1",
          "HTTP_VIA"                => "1.1 akamai.net(ghost) (AkamaiGHost), 1.1 vegur",

          # X Headers:
          "HTTP_X_AKAMAI_CONFIG_LOG_DETAIL" => "true",

          # The leftmost IP is the:
          # - Closer to the User (or the actual user IP)
          # - Less trustable
          "HTTP_X_FORWARDED_FOR"      => "190.113.210.147, 216.246.75.208",
          "HTTP_X_NOKIA_IMSI"         => "716100316259449",
          "HTTP_X_REQUEST"            => "272aa345-55cc-45b2-b879-79678957817f",

          "HTTP_X_REQUEST_START"      => "1427225820026",
          "HTTP_X_FORWARDED_PORT"     => "80",
          "HTTP_X_FORWARDED_PROTO"    => "http",
          "HTTP_X_UP_CALLING_LINE_ID" => "51941037249"
        )
      end
    end

    factory :mobile_request_from_vivo_brasil do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"           =>  "187.26.59.4",
          "HTTP_X_UP_CH_MSISDN"   =>  "5500000000000"
        )
      end
    end

    # TODO: Replace with a real example:
    factory :mobile_request_from_claro_panama do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"     => "181.178.231.8",
          "HTTP_X_UP_SUBNO" => "5070000000"
        )
      end
    end

    # http://myip.ms/view/ip_owners/7424/Telefonica_Del_Peru_Saa.html
    factory :mobile_request_from_movistar_peru do
      initialize_with do
        new build(:common_mobile_request_env).merge(
          "REMOTE_ADDR"               => "190.42.165.87",
          "HTTP_X_UP_CALLING_LINE_ID" => "5112100000"
        )
      end
    end


  end
end
