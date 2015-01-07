require 'mobile_subscriber/dictionaries/dialing_and_country_codes'
module MobileSubscriber
  module Detection

    # Módulo que provee métodos de deteccion y validacion para MSISDN por el
    # header de HTTP 'Msisdn':
    #  - Comcel Colombia
    module FromXUpSubnoHttpRequestHeader

      extend ActiveSupport::Concern

      module ClassMethods
        def extract_from_x_up_subno_http_request_header(request)
          header_name = 'X-Up-Subno'
          header_env_key = "HTTP_#{header_name.gsub('-','_').upcase}"

          isdn_attributes = nil

          isdn_attributes = if msisdn = request.env[header_env_key] and msisdn.strip.length >= 8
            msisdn.strip!
            detection_cues = {
              remote_ip: request.env["REMOTE_ADDR"],
              http_request_headers: { header_name => msisdn }
            }

            country_code = MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]]

            # Determinar la procedencia del MSISDN
            # TODO: Validar por IP, etc.
            case country_code
            when 'CO'
              # Comcel Colombia
              {
                id: msisdn,
                mobile_country_code: "732",
                mobile_network_code: "101"
              }.merge(detection_cues: detection_cues)
            end

          end

          isdn_attributes
        end
      end

    end
  end
end
