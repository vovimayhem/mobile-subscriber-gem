# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  # Real request captured on claroapps.com at 2015-03-13
  factory :mobile_request_from_claro_argentina, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR"           =>  "23.15.7.188",
        "HTTP_ACCEPT" => "multipart/mixed, application/vnd.wap.multipart.mixed, application/vnd.wap.xhtml+xml, application/xhtml+xml, text/vnd.wap.wml, */*",
        "HTTP_ACCEPT_CHARSET"=> "utf-8,utf-16,iso-8859-1,iso-10646-ucs-2,Shift_JIS,Big5",
        "HTTP_ACCEPT_ENCODING"=>"gzip",
        "HTTP_ACCEPT_LANGUAGE"=>"es",
        "HTTP_AKAMAI_ORIGIN_HOP"=>"1",
        "HTTP_CACHE_CONTROL"=>"no-cache, max-age=0",
        "HTTP_CONNECTION"=>"close",
        "HTTP_CONNECT_TIME"=>"4",
        "HTTP_COOKIE" => "request_method=GET; HttpOnly=; ",
        "HTTP_COOKIE2"=>"$Version=1",
        "HTTP_HOST"=>"www.claroapps.com",
        "HTTP_PRAGMA"=>"no-cache",
        "HTTP_TOTAL_ROUTE_TIME"=>"0",
        "HTTP_USER_AGENT"=> "SonyEricssonW580i/R8BE Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1",
        "HTTP_VERSION"=>"HTTP/1.1",
        "HTTP_VIA"=>"1.1 akamai.net(ghost) (AkamaiGHost), 1.1 vegur",
        "HTTP_X_AKAMAI_CONFIG_LOG_DETAIL"=>"true",
        "HTTP_X_FORWARDED_FOR"=>"172.65.159.141, 170.51.255.15, 23.15.7.188",
        "HTTP_X_FORWARDED_PORT"=>"80",
        "HTTP_X_FORWARDED_PROTO"=>"http",
        "HTTP_X_NOKIA_BEARER"=>"CSD or GPRS or 3G",
        "HTTP_X_NOKIA_CHARGINGID"=>"-335177295",
        "HTTP_X_NOKIA_GATEWAY"=>"NBG/4.0/1",
        "HTTP_X_NOKIA_GGSNIPADDRESS"=>"170.51.252.245",
        "HTTP_X_NOKIA_IMSI"=>"722310115238848",
        "HTTP_X_NOKIA_IPADDRESS"=>"172.65.159.141",
        "HTTP_X_NOKIA_LOCALSOCKET"=>"192.168.16.239:8080",
        "HTTP_X_NOKIA_MAXDOWNLINKBITRATE"=>"0",
        "HTTP_X_NOKIA_MAXUPLINKBITRATE"=>"0",
        "HTTP_X_NOKIA_MSISDN"=>"5491126368595",
        "HTTP_X_NOKIA_PREPAIDID"=>"4",
        "HTTP_X_NOKIA_REMOTESOCKET"=>"172.65.159.141:16513",
        "HTTP_X_NOKIA_ROAMINGID"=>"1",
        "HTTP_X_NOKIA_SGSNIPADDRESS"=>"186.158.128.49",
        "HTTP_X_REQUEST"=>"3e0f82f8-b086-4ad2-8793-c60e6a94c443",
        "HTTP_X_REQUEST_START"=>"1426256922162",
        "HTTP_X_WAP_PROFILE"=>"\"http://wap.sonyericsson.com/UAprof/W580iR201.xml\""
      )
    end
  end

  factory :mobile_request_from_claro_brasil, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "201.23.176.202",
        "HTTP_MSISDN" =>  "5500000000000"
      )
    end
  end

  # TODO: Replace with a real example:
  factory :mobile_request_from_claro_dominican_republic, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "181.37.104.3",
        "HTTP_MSISDN" =>  "18098591800"
      )
    end
  end

  # http://ns.myip.ms/view/ip_owners/181034/Claro_Chile_S_a.html
  factory :mobile_request_from_claro_chile, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "191.116.39.114",
        "HTTP_X_WAP_MSISDN" =>  "56024440000"
      )
    end
  end

  factory :mobile_request_from_claro_colombia, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "200.26.137.100",
        "HTTP_X_UP_SUBNO" =>  "57000000000"
      )
    end
  end

  # TODO: Replace with a real example request:
  factory :mobile_request_from_claro_costa_rica, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "186.26.126.37",
        "HTTP_X_NOKIA_MSISDN" =>  "50600000000"
      )
    end
  end

  # TODO: Replace with a real example request:
  factory :mobile_request_from_claro_puerto_rico, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "64.237.130.12",
        "HTTP_X_NOKIA_MSISDN" =>  "17872889401" # 1-787-XXXXXXXX
      )
    end
  end

  # http://myip.ms/view/ip_owners/80612/Conecel.html
  factory :mobile_request_from_claro_ecuador, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "190.63.1.10",
        "HTTP_MSISDN" =>  "59342690000"
      )
    end
  end

  # Request from a client through Claro Guatemala network:
  # (Built from an actual ATP test)
  factory :mobile_request_from_claro_guatemala, parent: :mobile_request do
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
  factory :mobile_request_from_claro_honduras, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "190.107.157.31",
        "HTTP_X_NOKIA_MSISDN" => "50430000000"
      )
    end
  end

  # TODO: Replace with a real example request:
  factory :mobile_request_from_claro_nicaragua, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "190.212.88.8",
        "HTTP_X_NOKIA_MSISDN" =>  "50500000000"
      )
    end
  end

  # TODO: Replace with a real example request:
  factory :mobile_request_from_claro_el_salvador, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" =>  "190.86.139.225",
        "HTTP_X_NOKIA_MSISDN" =>  "50300000000"
      )
    end
  end

  # Real request recorded at claroapps.com at 2015-03-24
  factory :mobile_request_from_claro_peru, parent: :mobile_request do
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

  # Real request sample captured at claroapps.com on 2015-03-13
  factory :mobile_request_from_claro_panama, parent: :mobile_request do
    initialize_with do
      new build(:common_mobile_request_env).merge(
        "REMOTE_ADDR" => "216.246.75.196",

        # Client generated headers:
        "HTTP_ACCEPT"          => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "HTTP_ACCEPT_ENCODING" => "gzip",
        "HTTP_ACCEPT_LANGUAGE" => "es-es",
        "HTTP_CONNECTION"      => "close",
        "HTTP_HOST"            => "api.claroapps.com",
        "HTTP_PRAGMA"          => "no-cache",
        "HTTP_USER_AGENT"      => "Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B466 Safari/600.1.4",
        "HTTP_VERSION"         => "HTTP/1.1",

        # Mobile Network generated headers:
        "HTTP_X_APN"      => "web.claro.com.pa",
        "HTTP_X_IMSI"     => "714030003647380",
        "HTTP_X_UP_SUBNO" => "50762526353",

        # Akamai generated/modified headers:
        "HTTP_AKAMAI_ORIGIN_HOP"          => "1",
        "HTTP_CONNECT_TIME"               => "1",
        "HTTP_CACHE_CONTROL"              => "no-cache, max-age=0",
        "HTTP_X_AKAMAI_CONFIG_LOG_DETAIL" => "true",
        "HTTP_TOTAL_ROUTE_TIME"           => "0",
        "HTTP_VIA"                        => "1.1 akamai.net(ghost) (AkamaiGHost), 1.1 vegur",
        "HTTP_X_FORWARDED_FOR"            => "181.179.0.28, 216.246.75.196",
        "HTTP_X_FORWARDED_PORT"           => "80",
        "HTTP_X_FORWARDED_PROTO"          => "http",
        "HTTP_X_REQUEST"                  => "d141e3e0-0282-4f44-9e45-470a834976a1",
        "HTTP_X_REQUEST_START"            => "1426248962827"
      )
    end
  end

end
