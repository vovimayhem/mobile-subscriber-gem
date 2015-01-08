module MobileSubscriber::Detection
  class HttpRequestInfo
    attr_reader :remote_ip, :headers

    def initialize(env)

      @remote_ip = env['REMOTE_ADDR']

      # Reference Links:
      # - http://www.slideshare.net/DefCamp/mobile-networks-exploiting-http-headers-and-data-traffic
      # - http://www.mulliner.org/collin/academic/publications/mobile_web_privacy_icin10_mulliner.pdf
      @headers = [
        # HTTP Headers that contain important request details for validation
        'Max-Forwards',   # Para validar el número de forwards que el cliente permite... muy pobre..
        'Via',
        'X-Forwarded-For', # lista de IP's que originaron la petición, en caso de pasar por proxies:

        # HTTP headers that contain the MSISDN:
        # http://www.mulliner.org/collin/academic/publications/mobile_web_privacy_icin10_mulliner.pdf
        'Cookie',
        'Igcli',
        'Msisdn',
        'Rapmin',
        'X-Fh-Msisdn',
        "X-H3-G-Msisdn",
        'X-Hts-Clid',
        'X-Jinny-Cid',
        'X-Msisdn',
        'X-Msp-Clid',
        'X-Msp-Msisdn',
        'X-Network-Info',
        'X-Nokia-Msisdn',
        'X-Nx-Clid',
        'X-Orange-Cli',
        'X-Up-Calling-Line',
        'X-Up-Calling-Line-Id',     # Not in referenced literature
        'X-Up-Ch-Msisdn',           # Not in referenced literature
        'X-Up-Lsid',
        'X-Up-Subno',               # Not in referenced literature
        'X-Wap-Fh-Subscriber-Info',
        'X-Wap-Msisdn',
        'X-Wap-Sesiones3g-Mdn',     # Not in referenced literature
        'X-Wsb-Cli',

        # Headers that contain bearer information:
        # http://www.mulliner.org/collin/academic/publications/mobile_web_privacy_icin10_mulliner.pdf
        'Bearer',
        'Bearer-Indication',
        'New-Bearer-Header',
        'Nokia-Bearer',
        'X-Nokia-Bearer',
        'X-Nokia-Musicshop-Bearer',
        'X-Up-Bear-Type',           # NOT A TYPO
        'X-Up-Bearer-Type',
        'X-Bearer-Type',

        # Headers that contain roaming information:
        # http://www.mulliner.org/collin/academic/publications/mobile_web_privacy_icin10_mulliner.pdf
        'X-Orange-Roaming',
        'X-Nokia-Roaming',
        'X-Roaming',
        'X-Sdp-Roaming'
      ].inject({}.with_indifferent_access) do |collected_headers, header_name|
        header_env_key = "HTTP_#{header_name.gsub('-','_').upcase}"

        if env.has_key? header_env_key
          collected_headers[header_name] = env[header_env_key].strip
        end

        collected_headers
      end

    end
  end
end
