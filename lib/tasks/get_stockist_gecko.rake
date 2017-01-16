# APP_KEY = 'ness7afbzbssotj'
# APP_SECRET = 'z5z48xgmqtxik80'
#encoding UTF-8
desc "Get Stockists"
task :get_stockists_gecko => :environment do
  # get_client
  puts 'Connecting to TG'
  puts 'Standing the stockists...'
  standby_stockists
  puts 'Updating Stockists...'

  StockistService.match_companies 
  
  puts 'Offlining stockists not in list...'
  offlining_stockists

end

task :process_stockists_gecko => :environment do

  StockistService.process_all_data

end

def standby_stockists
  Stockist.active.each do |stockist|
    stockist.status = 2
    stockist.save!
  end
end

def offlining_stockists
  Stockist.standby.each do |stockist|
    stockist.status = 3
    puts "Offline: #{stockist.name}"
    stockist.save!
  end
end
