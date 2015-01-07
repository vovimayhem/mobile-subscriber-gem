module MobileSubscriber
  module Detection

    # Módulo que provee métodos de deteccion y validacion para MSISDN's de:
    # - Telcel México
    # - Claro Argentina
    module FromXNokiaMsisdnHttpRequestHeader

      extend ActiveSupport::Concern

      module ClassMethods
        def extract_from_x_nokia_msisdn_http_request_header(request)

          header_name = 'X-Nokia-Msisdn'
          header_env_key = "HTTP_#{header_name.gsub('-','_').upcase}"

          isdn_attributes = if msisdn = request.env[header_env_key] and msisdn.length >= 8
            detection_cues = {
              remote_ip: request.env["REMOTE_ADDR"],
              http_request_headers: { 'X-Nokia-Msisdn' => msisdn }
            }

            country_code = MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]]

            # Determinar la procedencia del MSISDN
            # TODO: Validar por IP, etc.
            case country_code
            when 'MX'
              # Telcel México:
              {
                id: msisdn,
                mobile_country_code: "334",
                mobile_network_code: "020"
              }.merge(detection_cues: detection_cues)

            # Claro Argentina:
            when 'AR'
              {
                id: msisdn,
                mobile_country_code: "722",
                mobile_network_code: "330"
              }.merge(detection_cues: detection_cues)
            end
          end

          isdn_attributes
        end

      end
    end
  end
end
