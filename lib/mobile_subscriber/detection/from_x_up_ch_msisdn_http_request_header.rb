require 'mobile_subscriber/dictionaries/dialing_and_country_codes'
module MobileSubscriber
  module Detection

    # Módulo que provee métodos de deteccion y validacion para MSISDN's de:
    # - Vivo Brasil
    module FromXUpChMsisdnHttpRequestHeader

      extend ActiveSupport::Concern

      module ClassMethods
        def extract_from_x_up_ch_msisdn_http_request_header(request)
          header_name = 'X-Up-Ch-Msisdn'
          header_env_key = "HTTP_#{header_name.gsub('-','_').upcase}"

          isdn_attributes = if msisdn = request.env[header_env_key] and msisdn.strip.length >= 8
            msisdn.strip!
            detection_cues = {
              remote_ip: request.env["REMOTE_ADDR"],
              http_request_headers: { 'X-Up-Ch-Msisdn' => msisdn }
            }

            country_code = MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]] || MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,3]]

            # Determinar la procedencia del MSISDN
            # TODO: Validar por IP, etc.
            case country_code
            when 'BR'
              # Vivo:
              # TODO: Determinar el MNC correcto (06, 10, 11, 23)
              {
                id: msisdn,
                mobile_country_code: "724",
                mobile_network_code: "06"
              }.merge(detection_cues: detection_cues)
            end

          end
          isdn_attributes
        end

      end

    end
  end
end
