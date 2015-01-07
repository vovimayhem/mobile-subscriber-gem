require 'mobile_subscriber/dictionaries/dialing_and_country_codes'
module MobileSubscriber
  module Detection

    # Módulo que provee métodos de deteccion y validacion para MSISDN por el
    # header de HTTP 'X-Up-Calling-Line-Id':
    # - Claro Perú
    # - TIM (Telecom Italia Mobile) Brasil
    # - OI Brasil
    # - Movistar México
    # - Movistar Argentina
    # - Movistar Ecuador
    # - Movistar Perú
    module FromXUpCallingLineIdHttpRequestHeader

      extend ActiveSupport::Concern

      module ClassMethods
        def extract_from_x_up_calling_line_id_http_request_header(request)
          header_name = 'X-Up-Calling-Line-Id'
          header_env_key = "HTTP_#{header_name.gsub('-','_').upcase}"

          isdn_attributes = if msisdn = request.env[header_env_key] and msisdn.strip.length >= 8
            msisdn.strip!
            detection_cues = {
              remote_ip: request.env["REMOTE_ADDR"],
              http_request_headers: { header_name => msisdn }
            }

            country_code = MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]] || MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,3]]

            case country_code
            when 'PE'
              if (http_request_via_header = request.env["HTTP_VIA"]).present? and http_request_via_header =~ /Comverse/i
                # Is Claro Peru subscriber:
                detection_cues[:http_request_headers]['Via'] = http_request_via_header
                {
                  id: msisdn,
                  mobile_country_code: "716",
                  mobile_network_code: "10"
                }.merge(detection_cues: detection_cues)
              else
                # Is a Movistar Peru subscriber:
                {
                  id: msisdn,
                  mobile_country_code: "716",
                  mobile_network_code: "06"
                }.merge(detection_cues: detection_cues)
              end
            when 'BR'
              if http_request_x_msp_apn_header = request.env["HTTP_X_MSP_APN"] and http_request_x_msp_apn_header.present?
                detection_cues[:http_request_headers]['X-Msp-Apn'] = http_request_x_msp_apn_header
                if http_request_x_msp_apn_header =~ /OI/i
                  # Is a Oi Brazil subscriber:
                  {
                    id: msisdn,
                    mobile_country_code: "724",
                    mobile_network_code: "30"
                  }.merge(detection_cues: detection_cues)
                else
                  # Is a TIM Brasil subscriber:
                  {
                    id: msisdn,
                    mobile_country_code: "724",
                    mobile_network_code: "02"
                  }.merge(detection_cues: detection_cues)
                end
              end
            when 'MX'
              # Is a Movistar Mexico subscriber:
              {
                id: msisdn,
                mobile_country_code: "334",
                mobile_network_code: "030"
              }.merge(detection_cues: detection_cues)
            when 'AR'
              # Is a Movistar Argentina subscriber:
              # TODO: Detect if MNC is 010 or 070 (Different MHz Bands)
              {
                id: msisdn,
                mobile_country_code: "722",
                mobile_network_code: "010"
              }.merge(detection_cues: detection_cues)
            when 'EC'
              # Is a Movistar Ecuador subscriber:
              {
                id: msisdn,
                mobile_country_code: "740",
                mobile_network_code: "00"
              }.merge(detection_cues: detection_cues)
            end
          end

          isdn_attributes
        end
      end

    end
  end
end
