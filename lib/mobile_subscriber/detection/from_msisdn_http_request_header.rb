require 'mobile_subscriber/dictionaries/dialing_and_country_codes'

module MobileSubscriber
  module Detection

    # Módulo que provee métodos de detección y validacion para MSISDN por el
    # header de HTTP 'Msisdn':
    # - Claro Brasil
    # - Claro Chile
    # - Claro Colombia
    # - Claro Costa Rica
    # - Claro República Dominicana
    # - Claro Ecuador
    # - Claro El Salvador
    # - Claro Guatemala
    # - Claro Nicaragua
    # - Claro Panamá
    # - Claro Paraguay
    module FromMsisdnHttpRequestHeader

      extend ActiveSupport::Concern

      module ClassMethods
        def extract_from_msisdn_http_request_header(request)
          header_name = 'Msisdn'
          header_env_key = "HTTP_#{header_name.gsub('-','_').upcase}"

          isdn_attributes = nil

          isdn_attributes = if msisdn = request.env[header_env_key] and msisdn.strip.length >= 8
            msisdn.strip!
            detection_cues = {
              remote_ip: request.env["REMOTE_ADDR"],
              http_request_headers: { 'Msisdn' => msisdn }
            }

            country_code = MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]] || MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,3]]

            # Determinar la procedencia del MSISDN
            # TODO: Validar por IP, etc.
            case country_code
            when 'BR'
              # Claro Brasil
              # TODO: Determinar correctamente el MNC (05, 38)
              {
                id: msisdn,
                mobile_country_code: "724",
                mobile_network_code: "05"
              }.merge(detection_cues: detection_cues)
            when 'CL'
              # Claro Chile
              {
                id: msisdn,
                mobile_country_code: "730",
                mobile_network_code: "03"
              }.merge(detection_cues: detection_cues)
            when 'CO'
              # Claro Colombia
              {
                id: msisdn,
                mobile_country_code: "732",
                mobile_network_code: "101"
              }.merge(detection_cues: detection_cues)
            when 'CR'
              # Claro Costa Rica
              {
                id: msisdn,
                mobile_country_code: "712",
                mobile_network_code: "03"
              }.merge(detection_cues: detection_cues)
            when 'DO'
              # Claro Dominicana:
              {
                id: msisdn,
                mobile_country_code: "370",
                mobile_network_code: "02"
              }.merge(detection_cues: detection_cues)
            when 'EC'
              # Claro Ecuador:
              {
                id: msisdn,
                mobile_country_code: "740",
                mobile_network_code: "01"
              }.merge(detection_cues: detection_cues)
            when 'SV'
              # Claro El Salvador:
              {
                id: msisdn,
                mobile_country_code: "706",
                mobile_network_code: "01"
              }.merge(detection_cues: detection_cues)
            when 'GT'
              # Claro Guatemala:
              {
                id: msisdn,
                mobile_country_code: "704",
                mobile_network_code: "01"
              }.merge(detection_cues: detection_cues)
            when 'HN'
              # Claro Honduras:
              {
                id: msisdn,
                mobile_country_code: "708",
                mobile_network_code: "001"
              }.merge(detection_cues: detection_cues)
            when 'NI'
              # Claro Nicaragua:
              {
                id: msisdn,
                mobile_country_code: "710",
                mobile_network_code: "21"
              }.merge(detection_cues: detection_cues)
            when 'PA'
              # Claro Panamá:
              {
                id: msisdn,
                mobile_country_code: "714",
                mobile_network_code: "03"
              }.merge(detection_cues: detection_cues)
            when 'PY'
              # Claro Paraguay:
              {
                id: msisdn,
                mobile_country_code: "744",
                mobile_network_code: "02"
              }.merge(detection_cues: detection_cues)
            end

          end

          isdn_attributes
        end
      end

    end
  end
end
