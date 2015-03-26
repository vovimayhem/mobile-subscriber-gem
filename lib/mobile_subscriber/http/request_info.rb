require 'mobile_subscriber/http/known_imsi_headers'
require 'mobile_subscriber/http/known_msisdn_headers'

module MobileSubscriber::HTTP

  class RequestInfo

    attr_reader :remote_ip, :headers,
                :imsi,   :detected_imsi_header_name,
                :msisdn, :detected_msisdn_header_name,
                :mcc, :mnc

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
        'X-Imsi',
        'X-Jinny-Cid',
        'X-Msisdn',
        'X-Msp-Clid',
        'X-Msp-Msisdn',
        'X-Network-Info',
        'X-Nokia-Imsi',             # This is a VERY useful one... if you have it!
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
        'X-Ztgo-Beareraddress',     # Not in referenced literature

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
        header_env_key = "HTTP_#{header_name.split('-').map(&:upcase).join('_')}"

        if env.has_key? header_env_key
          collected_headers[header_name] = env[header_env_key].strip
        end

        collected_headers
      end

      # IMSI Extraction:
      # Extract the first IMSI Header Value:
      @imsi, @detected_imsi_header_name = MobileSubscriber::HTTP::KNOWN_IMSI_HEADER_MCC_MNC.inject([nil,nil]) do |result, keyval|
        header_name = keyval[0]
        if result.compact.blank? and current_imsi = headers[header_name]
          result = [current_imsi, header_name] if current_imsi.length >= 14
        end
        result
      end

      # MSISDN Extraction:
      # Extract the first MSISDN Header Value:
      @msisdn, @detected_msisdn_header_name = MobileSubscriber::HTTP::KNOWN_MSISDN_HEADER_MCC_MNC.inject([nil,nil]) do |result, keyval|
        header_name = keyval[0]
        if result.compact.blank? and current_msisdn = headers[header_name]
          result = [current_msisdn, header_name] if current_msisdn.length >= 8
        end
        result
      end

      # Mobile Operator Info Extraction:
      extract_mobile_operator_info!

    end

    def has_imsi?
      imsi.present?
    end

    def has_msisdn?
      msisdn.present?
    end

    private

      def extract_mobile_operator_info!

        tuples_by_imsi = if has_imsi?
          MobileSubscriber::HTTP::KNOWN_IMSI_HEADER_MCC_MNC[detected_imsi_header_name]
        end

        tuples_by_msisdn = if has_msisdn?
          MobileSubscriber::HTTP::KNOWN_MSISDN_HEADER_MCC_MNC[detected_msisdn_header_name]
        end

        tuples_to_check = if tuples_by_imsi.present? && tuples_by_msisdn.present?
          # Intersect known data from request - less tuples to check later
          tuples_by_imsi & tuples_by_msisdn
        elsif tuples_by_imsi.present?
          tuples_by_imsi
        elsif tuples_by_msisdn.present?
          tuples_by_msisdn
        end

        detected_mobile_operator_info = if tuples_to_check.present? && tuples_to_check.any?
          if has_imsi?
            tuples_to_check.detect { |tuple| imsi.start_with?(tuple.join) }
          elsif has_msisdn?

            msisdn_country_code = (1..4).to_a.reverse.inject(nil) do |code, prefix_length|
              current_prefix = msisdn[0,prefix_length]
              if code.nil?
                code = MobileSubscriber::DIALING_COUNTRY_CODES[current_prefix]
              end
              code
            end

            msisdn_mcc = MobileSubscriber::MCC_ISO_COUNTRY_CODES.detect { |key, val| val == msisdn_country_code }.first

            # TODO Check for duplicates!
            tuples_to_check.detect { |tuple| tuple.first == msisdn_mcc }

          end
        end

        @mcc, @mnc = detected_mobile_operator_info if detected_mobile_operator_info.present?

      end

  end
end
