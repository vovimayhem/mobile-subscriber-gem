require 'mobile_subscriber/dictionaries/dialing_and_country_codes'

module MobileSubscriber::Detection

  # Módulo que provee métodos de deteccion y validacion para MSISDN por el
  # header de HTTP 'X-Up-Calling-Line-Id':
  # - Claro Perú
  # - TIM (Telecom Italia Mobile) Brasil
  # - OI Brasil
  # - Movistar México
  # - Movistar Argentina
  # - Movistar Perú
  module FromXUpCallingLineIdHttpRequestHeader

    def extract_from_x_up_calling_line_id_http_request_header(http_request_info)
      if msisdn = http_request_info.headers['X-Up-Calling-Line-Id'] and msisdn.length >= 8

        country_code = (
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]] ||
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,3]]
        )

        # Determine the Network Operator tuple (MCC + MNC):
        # TODO: Validate IP ranges, additional headers, etc.
        network_id_tuple = case country_code
        when 'PE'
          # Claro Perú includes the "X-Nokia-Imsi" header...
          imsi = http_request_info.headers['X-Nokia-Imsi']
          if imsi.present?
            # Claro Peru: (IP's 190.113.x)
            { mcc: "716", mnc: "10" } if imsi.start_with?('71610')
          else
            # Movistar Peru: (IP's 190.238.x)
            { mcc: "716", mnc: "06" }
          end
        when 'BR'
          if x_msp_apn_header = request.env["X-Msp-Apn"] and x_msp_apn_header.present?
            if http_request_x_msp_apn_header =~ /OI/i
              # Oi Brazil:
              { mcc: "724", mnc: "30" }
            else
              # TIM Brazil:
              { mcc: "724", mnc: "02" }
            end
          end
        when 'MX' # Movistar Mexico:
          { mcc: "334", mnc: "030" }
        when 'AR' # Movistar Argentina:
          # TODO: Determine (if possible) the MNC (010 or 070)
          { mcc: "722", mnc: "010" }
        end

        # Return only if we identified the network:
        if network_id_tuple.present?
          {
            id:                   msisdn,
            mobile_country_code:  network_id_tuple[:mcc],
            mobile_network_code:  network_id_tuple[:mnc],
            http_request_info:    http_request_info
          }
        end
      end
    end
  end
end
