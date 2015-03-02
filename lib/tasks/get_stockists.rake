# APP_KEY = 'ness7afbzbssotj'
# APP_SECRET = 'z5z48xgmqtxik80'
#encoding UTF-8
desc "Get Stockists"
task :get_stockists => :environment do
  # get_client
  puts 'Grabbing the file...'
  the_file = client.media('/30 Acres - Eye of Horus Retail Centre/stockist-data/retailers.xls')
  the_file.inspect
  puts 'Checking the headers...'
  parse_xls(the_file['url'], 'check_headers')
  puts 'Standing the stockists...'
  standby_stockists
  puts 'Updating Stockists...'
  parse_xls(the_file['url'], 'update_stockists')
  puts 'Offlining stockists not in list...'
  offlining_stockists

end

def client
  # Install this the SDK with "gem install dropbox-sdk"
  require 'dropbox_sdk'
  # Get your app key and secret from the Dropbox developer website
  # flow = DropboxOAuth2FlowNoRedirect.new(APP_KEY, APP_SECRET)
  # authorize_url = flow.start()
  # # Have the user ign in and authorize this app
  # puts '1. Go to: ' + authorize_url
  # puts '2. Click "Allow" (you might have to log in first)'
  # puts '3. Copy the authorization code'
  # print 'Enter the authorization code here: '
  # # code = gets.strip
  # code = '1VAsKEO59SAAAAAAAAAAEautr7szlLBzBrhLRZ0MZ04'
  # # This will fail if the user gave us an invalid authorization code
  # access_token, user_id = flow.finish(code)
  # puts access_token
  access_token = 'peIHv38CaNcAAAAAAAC20raFgkju_Is3QDqCWYW1K8hyZcX0shOD-b-nMFZG7DO6'
  # client = 
  DropboxClient.new(access_token)
  # puts "linked account:", client.account_info().inspect
end

def parse_xls(file, task)
  require 'roo'
  require 'spreadsheet'
  s = Roo::Spreadsheet.open(file)         # loads an Excel Spreadsheet for Excel .xlsx
  s.default_sheet = s.sheets.first
  if task == 'check_headers'
    check_headers(s)
  end
  if task == 'update_stockists'
    update_stockists(s)
  end
end

def check_headers(s)
  headers = ['Contact',	'Company',	'First name',	'Last name',	'Street',	'Suburb', 'City',	'Code', 'County/State', 'Credit limit', 'Credit days', 'Created',nil, 'Email address', 'Fax', nil,	'Last contacted', 'Mobile', 'Mailmerges',	'Postcode',	'Telephone', 'Retailers','Retailers','Country','Last ordered']
  headers.each_with_index do |check, index|
    col = index + 1
    heading = s.cell(1, col)
    puts (heading == check ? "#{check} correct" : "#{check} wrong : #{heading}")
    if heading != check 
      puts 'broken'
      break
    end
  end
end

def standby_stockists
  Stockist.all.each do |stockist|
    stockist.status = 2
    stockist.save!
  end
end

def update_stockists(s)
  (s.first_row..s.last_row).each do |row|
    puts s.row(row).inspect
    unless row == 1
      stockist = Stockist.find_or_initialize_by(client_id: s.cell(row, 'A'))
      stockist.name = s.cell(row, 'B')
      stockist.first_name = s.cell(row, 'C')
      stockist.last_name = s.cell(row, 'D')
      stockist.street_address = s.cell(row, 'E')
      stockist.city = "#{s.cell(row, 'F')} #{s.cell(row, 'G')}"
      stockist.state = s.cell(row, 'I')
      stockist.secondary_phone = s.cell(row, 'R')
      stockist.postcode = s.cell(row, 'T')
      stockist.primary_phone = s.cell(row, 'U')
      stockist.email_address = s.cell(row, 'N')
      if stockist.street_address.nil? or stockist.street_address != s.cell(row,'E')
        stockist.street_address = s.cell(row,'E')
        stockist.geocode
      end
       country = Country.find_or_create_by(name: s.cell(row, 'X'))
       stockist.country_id = country.id
       country.save!
      ## Put them back online
      stockist.status = 1
      stockist.save!
      sleep(2)
      puts stockist
    end

  end
  # binding.pry

end

def offlining_stockists
  Stockist.standby.each do |stockist|
    stockist.status = 3
    puts "Offline: #{stockist.name}"
    stockist.save!
  end
end
