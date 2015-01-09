require "ipaddr"
module MobileSubscriber

  # Keys:   MCC + MNC
  # Values: IP Range (IPAddr object) or Tuple (To prevent duplication)
  # See:
  # - [IPAddr documentation](http://www.ruby-doc.org/stdlib-2.0/libdoc/ipaddr/rdoc/IPAddr.html#method-i-include-3F)
  OPERATOR_IP_RANGES = {

    # Telcel México (Radiomovil Dipsa, S.A. de C.V.)
    # http://myip.ms/view/ip_owners/91889/Radiomovil_Dipsa_S_a_De_C_v.html
    ["334", "020"] => [
      IPAddr.new("200.68.128.0/24"),
      IPAddr.new("200.95.168.0/24"),
      IPAddr.new("200.95.160.0/24"),
      IPAddr.new("200.95.170.0/24")
    ],

    # Claro Argentina (Amx Argentina S.a)
    # http://myip.ms/view/ip_owners/177168/Amx_Argentina_S_a.html
    ["722", "330"] => [
      IPAddr.new("186.122.0.0/24"),
      IPAddr.new("186.12.0.0/24"),
      IPAddr.new("186.157.0.0/24"),
      IPAddr.new("186.158.0.0/24"),
      IPAddr.new("170.51.0.0/24"),
      IPAddr.new("181.117.0.0/24"),
      IPAddr.new("181.116.0.0/24"),
      IPAddr.new("181.238.0.0/24"),
      IPAddr.new("186.123.0.0/24"),
      IPAddr.new("186.13.0.0/24")
    ]

  }
end
