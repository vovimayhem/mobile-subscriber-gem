require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'active_support/all'

require 'byebug'

class MobileSubscriber < Thor

  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  # Scrapes the Wikipedia entry of 'Mobile country code' to generate the dictionaries.
  desc "update_dictionaries", "Update the dictionaries file from Wikipedia info"
  def update_dictionaries()

    # Get the Wikipedia HTML and parse HTML with nokogiri:
    page = Nokogiri::HTML(open "https://en.wikipedia.org/wiki/Mobile_country_code")

    data = []

    # All 'wikitables' in page have data we need:
    wiki_content = page.xpath([
      '/html',
      'body',
      'div[@id="content"]',
      'div[@id="bodyContent"]',
      'div[@id="mw-content-text"]'
    ].join('/')).first

    wikitable_headers   = wiki_content.xpath('h2/span[@class="mw-headline" and @id="Test_networks" or @id="International_operators"]|h4/span[@class="mw-headline"]')
    wikitables          = wiki_content.xpath('table[@class="wikitable"]')


    country_codes = wikitable_headers.map { |x| x.text.split(' - ').last.split('[').first }
    # contry_codes.map! { |x| ["Test networks","International operators"].include?(x) ? nil : x }

    # Llenar el array de datos:
    wikitables.each_with_index do |wikitable, index|
      wikitable.xpath('tr[./td]').each do |wikitable_row|
        data_cells = wikitable_row.xpath('td').map { |x| x.text.strip }

        base_data_row = {
          country_code:         country_codes[index],
          mobile_country_code:  data_cells[0],
          brand:                data_cells[2],
          operator:             data_cells[3],
          status:               data_cells[4],
          bands:                data_cells[5].split('/').map(&:strip),
          notes:                data_cells[6]
        }
        base_data_row.delete :brand if base_data_row[:brand].blank?
        base_data_row.delete :notes if base_data_row[:notes].blank?

        if data_cells[1] =~ /\A[0-9-]{2,7}\z/i

          first_mnc, last_mnc = data_cells[1].split('-')
          last_mnc = first_mnc if last_mnc.blank?
          mnc_length = first_mnc.length

          Range.new(first_mnc.to_i, last_mnc.to_i).each do |mnc|
            data << base_data_row.merge(mobile_network_code: mnc.to_s.rjust(mnc_length, '0'))
          end
        else
          data << base_data_row.merge(mobile_network_code: data_cells[1])
        end
      end
    end

    # Generate the MCC => ISO 3966 Country Code Dictionary:
    @mcc_iso_country_codes = data.map do |x|
      [x[:mobile_country_code], x[:country_code]]
    end.inject({}) do |hsh, keyval|
      hsh[keyval[0]] = keyval[1]
      hsh
    end
    @mcc_iso_country_codes.delete ""
    @mcc_iso_country_codes = Hash[@mcc_iso_country_codes.sort]
    template 'templates/mobile_and_iso_country_codes.rb.erb', 'lib/mobile_subscriber/dictionaries/mobile_and_iso_country_codes.rb'

    # Generate the MCC+MNC => Operator Details Dictionary:
    @operator_data = data.inject({}) do |dict, row|
      key = [row[:mobile_country_code], row[:mobile_network_code]]
      dict[key] = {
        mobile_country_code: row[:mobile_country_code],
        mobile_network_code: row[:mobile_network_code]
      }.merge(Hash[row.except(:country_code, :mobile_country_code, :mobile_network_code).sort])
      dict
    end
    @operator_data.delete ["",""]
    @operator_data = Hash[@operator_data.sort]
    template 'templates/operator_data.rb.erb', 'lib/mobile_subscriber/dictionaries/operator_data.rb'

  end

  # Scrapes the Wikipedia entry of 'Mobile country code' to generate the dictionaries.
  desc "update_country_dialing_codes", "Update the country dialing codes dictionary from countrycode.org"
  def update_country_dialing_codes()

    # Get the Wikipedia HTML and parse HTML with nokogiri:
    page = Nokogiri::HTML(open "http://countrycode.org/")

    funky_stripper = -> (str, pttrn) { str.chars.select { |c| c =~ pttrn }.join }

    # Iterate over the main table > tbody > tr:
    @country_code_data = page.css('table#main_table_blue > tbody > tr').inject([]) do |list, t_row|
      t_cells = t_row.css('td')

      # Capture the country name:
      name = t_cells[0].text.strip

      # Capture the iso codes:
      # WTF strip does not work here to clear spaces!
      alpha_2, alpha_3 = t_cells[1].text.split('/').map { |str| funky_stripper.call(str, /[A-Z]/) }

      # Capture the dialing code:
      dialing = funky_stripper.call(t_cells[2].text, /\d/)

      # Add to list if alpha_2 and dialing code are both present:
      if alpha_2.present? && dialing.present?
        list << {
          country_name: name,
          iso_code_2:   alpha_2,
          iso_code_3:   alpha_3,
          dialing_code: dialing
        }
      end

      # Return updated list:
      list
    end

    template 'templates/dialing_and_country_codes.rb.erb', 'lib/mobile_subscriber/dictionaries/dialing_and_country_codes.rb'

  end

end
