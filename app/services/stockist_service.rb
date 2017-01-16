class StockistService
  require 'gecko-ruby'
  OAUTH_ID = '4d863145b73e63712fc5c48a78e341433dcd8d8be70f10d7a1b1744c1188e996'
  OAUTH_SECRET = 'e973d30240b7fdbf58d2999924cd790eff5390478fce6a24f52c877b00a0811e'
  # ACCESS_TOKEN = '220938f8ebb84995eda0db779dc340ec21160b1fb0bf0040e8a5714e5e3d002b'
  API_TOKEN = '0e8df89df8d3057ce76dabee53c64b791e3e6da04254334efa577589509f945c'

  def trade_gecko
    # Gecko::Client.new(OAUTH_ID, OAUTH_SECRET)
    gecko = Gecko::Client.new(OAUTH_ID, OAUTH_SECRET)
    access_token = OAuth2::AccessToken.new(gecko.oauth_client, API_TOKEN)
    gecko.access_token = access_token
    gecko
  end

  def get_companies(page=0)
    trade_gecko.Company.where(limit: 250, page: page, status: 'active')
  end

  def self.match_companies
    matches = []
    page = 0
    30.times do
      page = page + 1
      tg = StockistService.new
      tg.get_companies(page).each do |tg_stockist|

        sleep(1)
        puts "****************************************"
        if Stockist.where(name: tg_stockist.name).any?
          puts "== A N Y =="
          stockist = Stockist.where('name ILIKE ?', tg_stockist.name).first
          matches << tg_stockist.name
          unless tg_stockist.fax and tg_stockist.fax.include?('(R)')
            tg_stockist.fax = "(R) #{tg_stockist.fax}"
            tg_stockist.save
            stockist.trade_gecko = tg_stockist.id
          end
          stockist.status = 1
          stockist.save!
        else
          puts " === NONE === "
          if tg_stockist.fax
            puts " HAS FAX! "
            stockist = Stockist.where(name:tg_stockist.name).first_or_create
            stockist.data = tg_stockist.to_hash
            stockist.save!
          else
            puts "! NO FAX ! "
          end
        end
      end
    end
    puts matches
    puts "MATCHES COUNT #{matches.count}"
  end

  def self.process_all_data
    Stockist.all.each do |stockist|
      tg = StockistService.new

      if stockist.data and stockist.street_address.blank?
        address_id = stockist.data["address_ids"].first
        if address_id
          # binding.pry
          address = tg.trade_gecko.Address.find(address_id)
          if address
            #<Gecko::Record::Address id: 14295415, updated_at: "2017-01-03 22:21:36", created_at: "2017-01-03 22:21:36", company_id: 11827400, label: "Isabella Beauty", first_name: nil, last_name: nil, company_name: "Isabella Beauty", address1: "Storgata 12", address2: nil, suburb: "Glasshuspassasjen", city: "", state: "Bodø", country: "Norway", zip_code: "8006", phone_number: "97537658", email: "siljemm@live.no", status: "active">
            stockist.street_address = address.address1
            stockist.city = [address.suburb,address.city].join(',')
            stockist.country = Country.where(name: address.country).first_or_create
            stockist.postcode = address.zip_code
            stockist.primary_phone = address.phone_number
            stockist.email_address = address.email
            sleep(10) # for google
            stockist.save!
          end

        end
      end


    end
  end

end

# gecko = Gecko::Client.new(<OAUTH_ID>, <OAUTH_SECRET>)
# access_token = OAuth2::AccessToken.new(gecko.oauth_client, <ACCESS_TOKEN>)
# gecko.access_token = access_token
# gecko.Account.current
# # APP_KEY = 'ness7afbzbssotj'
# # APP_SECRET = 'z5z48xgmqtxik80'
