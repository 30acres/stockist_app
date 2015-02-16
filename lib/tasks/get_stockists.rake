#encoding UTF-8
desc "Get Stockists"
task :get_stockists => :environment do

    puts 'initializing'
    require 'open-uri'
    require 'csv'
    # require 'iconv'
    require 'mechanize'
    require 'pry'

    puts 'encoding code'
    puts 'getting file'

    ## DROPBOX WAY
    a = Mechanize.new { |agent|
      agent.follow_meta_refresh = true
    }


    begin
      home_page = a.get('https://www.dropbox.com/login') #?cont=https%3A//www.dropbox.com/') 
    rescue Mechanize::ResponseCodeError => exception
      if exception.response_code == '403'
        home_page = exception.page
      else
        raise # Some other error, re-raise
      end
    end

    login = home_page.form_with(:action => '/ajax_login') do |form|
      form.login_email  = 'jonny+eoh@dropbox.com'
      form.login_password = 'AwakenTheGoddess'
      @next_page = form.button_with(:class => "login-button button-primary")
      # form.click_button(@next_page)
      # a.submit(form, next_page)
      # next_page.click
      # a.click(next_page)
    end.submit
    raise 'Login Failed' if login.body !~ /Logged in!/
    
      puts 'HERE:'
      puts @next_page
      puts '___'
      binding.pry




    file_page = a.get("https://www.dropbox.com/home/stockists")
    # our_time = Time.now
    # puts "Day Now: " + our_time.strftime('%d%m%Y')
    # puts "Hour: " + our_time.strftime('%H')
    ## because of the ONQ naming convention, if the day is a single, we strip the ZERO to make it match
    # puts "Filename: Vacancy_data_#{our_time.strftime('%d').to_i <= 9 ? (our_time.strftime('%d').gsub('0','') + our_time.strftime('%m%Y')) : our_time.strftime('%d%m%Y')}_#{our_time.strftime('%H').to_i <= 13 ? "855" : "355"}.csv"

    #link = file_page.link_with(:href => /Vacancy_data_#{our_time.strftime('%d').to_i <= 9 ? (our_time.strftime('%d').gsub('0','') + our_time.strftime('%m%Y')) : our_time.strftime('%d%m%Y')}_#{our_time.strftime('%H').to_i <= 13 ? "855" : "355"}.csv/)
    link = file_page.link_with(:href => /Vacancy_data_#{our_time.strftime('%d').to_i <= 9 ? (our_time.strftime('%d').gsub('0','') + our_time.strftime('%m%Y')) : our_time.strftime('%d%m%Y')}_#{our_time.strftime('%H').to_i <= 13 ? "855" : "355"}.xml/)
    if link.nil?
      ReportMailer.import_failed.deliver
    end
    file_path = link.href.to_s + "?dl=1"

    # Click the upload link
    # upload_page = a.click(my_page.link_with(:text => "ONQ_Vacancies"))

    #file = Dir.glob("#{path}*").max_by {|f| File.mtime(f)}
    #puts "is there a file? #{file}"
    puts file_path
    ##binding.pry
    #contents = open(URI.parse(file_path)).read
    doc = Nokogiri::XML(open(file_path))
    doc.encoding = 'utf-8'
    #binding.pry
    #contents = doc.read
    #contents = File.read(file)

    puts 'detecting encoding'
    # this will detect and set the encoding of `contents`, then return self
    #contents.detect_encoding!

    puts 'kill listings for now...'
    #puts contents


    #def clean_utf(row)
    #  ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
    #  ic.iconv(row + ' ')[0..-2]
    #end

    puts 'find all branches'
    @branches = Branch.all

    #puts 'parse the csv'
    #csv = CSV.parse(clean_utf(contents))
    #
    #chop up the xml
    jobs = doc.child.children[4].children

    puts 'check the listings import status'
    @listings = Listing.all
    ## Live = 1, Held = 2, Killed = 3
    Listing.is_active.each do |listing|
      listing.update_attributes(:import_status => 2)
    end
    puts 'All killed'
 

    jobs.each do |job|
      import_hash = {}
      import_hash[:job_title] = job.children[0].child.child.try(:content)

      import_hash[:employer] = job.children[1].child.child.try(:content)
      import_hash[:in_rep_suburb] = job.children[2].child.child.try(:content)
      import_hash[:status] = job.children[3].child.child.try(:content)
      import_hash[:managing_site_code] = job.children[4].child.child.try(:content)
      import_hash[:job_description] = job.children[5].child.child.try(:content)
      import_hash[:essential_criteria] = job.children[6].child.child.try(:content)
      import_hash[:desired_criteria] = job.children[7].child.child.try(:content)
      import_hash[:ft_pt] = job.children[8].child.child.try(:content)
      import_hash[:industry] = job.children[9].child.child.try(:content)
      import_hash[:hours] = job.children[10].child.child.try(:content)
      import_hash[:to_apply] = job.children[11].child.child.try(:content)
      import_hash[:fill_by] = job.children[12].child.child.try(:content)
      import_hash[:positions_available] = job.children[13].child.child.try(:content)
      import_hash[:trainee_app] = job.children[14].child.child.try(:content)
      import_hash[:staff] = job.children[15].child.child.try(:content)
      import_hash[:created_by] = job.children[16].child.child.try(:content)
      import_hash[:created_ctx_fullname] = job.children[17].child.child.try(:content)
      import_hash[:created_tx_account_email] = job.children[18].child.child.try(:content)
      import_hash[:created_tx_account_status] = job.children[19].child.child.try(:content)
      import_hash[:modified_by] = job.children[20].child.child.try(:content)
      import_hash[:modified_by_ctx_fullname] = job.children[21].child.try(:content)
      import_hash[:modified_by_tx_account_email] = job.children[22].child.try(:content)
      import_hash[:modified_by_tx_account_status] = job.children[23].child.try(:content)
      import_hash[:vacancy_id] = job.children[24].child.child.try(:content)
      import_hash[:omit_mailing_list] = job.children[25].child.child.try(:content)

      ##binding.pry

    #without charlock
    #csv = CSV.parse(contents.force_encoding('BINARY').to_s.strip.gsub(/\P{ASCII}/, ''))

   #csv.each do |row|
     # puts "##################" 
     # row.each_with_index do |r, index|
     #   puts index
#
 #       puts r
  #    end
      puts " A.	Job Title: #{import_hash[:title]}"

      @branch_id = 0
      @branches.each do |b|
        if b.code.to_s == import_hash[:managing_site_code].to_s
          @branch_id = b.id
        end
      end

      if import_hash[:fill_by].nil?
        aussie_fill_by = ''
      elsif import_hash[:fill_by] == "Fill By"
        aussie_fill_by = ''
      else
        filler = import_hash[:fill_by].gsub("00",'').split('/')
        bob = "#{filler[2]},#{filler[1]},#{filler[0]}"
        #binding.pry
        fixed_fill_by_date = Date.strptime(bob, "%Y,%m,%d")
        aussie_fill_by = "#{filler[2]}-#{filler[1]}-#{filler[0]}"
      end

      if import_hash[:trainee_app].nil?
        des = ''
      else
        des = import_hash[:trainee_app]
      end

      @industry = Industry.find_or_create_by_title(:title => import_hash[:industry])
      puts 'CREATE LISTINGS'
      #@listing = Listing.new
      if import_hash[:job_title] == "Job Title"
        puts 'dud'
      elsif import_hash[:job_title] == "Created by DEN Jobseeker BDF Data Import"
        puts 'another dud'
      else
        @listing = Listing.find_or_initialize_by_vacancy_id(import_hash[:vacancy_id])

        @listing.update_attributes(
          # A.	Job Title
          :title => import_hash[:job_title],
          # B.	Employer	onq_status
          :employer => import_hash[:employer],
          # C.	Employer | Employer ID__
          :employer_id => "no value", 
          # D.	Employer ID::City	
          :employer_city => import_hash[:in_rep_suburb],
          # E.	Status	
          :onq_status => import_hash[:status],
          # F.	Managing Site Code	
          :site_code => import_hash[:managing_site_code],
          # figured out the branch_id above
          :branch_id => @branch_id != 0 ? @branch_id : BranchGroup.last.id,
          # G.	JOB Description
          :job_description => import_hash[:job_description] ? import_hash[:job_description].gsub(/\v/, "\n") : 'n/a',
          # H.	Essential Criteria	
          :essential_criteria => import_hash[:essential_criteria] ? import_hash[:essential_criteria].gsub(/\v/, "\n") : 'n/a',
          # I.	Desired Criteria	
          :desired_criteria => import_hash[:desired_criteria] ? import_hash[:desired_criteria].gsub(/\v/,"\n") : 'n/a',
          # J.	FT PT	
          :full_part_casual => import_hash[:ft_pt],
          # K.	Industry	
          :industry_id => @industry.id,
          # L.	Hours	
          :hours => import_hash[:hours],
          # M.	To Apply	
          :to_apply => import_hash[:to_apply],
          # N.	Fill By	
          :fill_by => aussie_fill_by,
          :fill_by_date => fixed_fill_by_date,
          # O.	Positions available	
          :positions_available => import_hash[:positions_available] == nil ? 1 : import_hash[:positions_available].to_i,
          # P.	Trainee App	
          :trainee_app => des,
          # Q.	Staff	@Created By	
          :staff_name => import_hash[:staff],
          # CODE
          :created_by_code => import_hash[:created_by],
          # R.	Authentication_ | @Created_By__tx_account_id::ctx_fullname	
          :created_by_name => import_hash[:created_ctx_fullname],
          # S.	Authentication_ | @Created_By__tx_account_id::tx_account_email	
          :created_by_email => import_hash[:created_tx_account_email],
          # T.	Authentication_ | @Created_By__tx_account_id::tx_account_status	
          :created_by_status => import_hash[:created_tx_account_status],
          # U.	@Modified By	Authentication_ | 
          :last_modified_by_name => import_hash[:modified_by_ctx_fullname],
          # V.	@Modified_By__tx_account_id::ctx_fullname	
          :last_modified_by_code => import_hash[:modified_by],
          # W.	Authentication_ | @Modified_By__tx_account_id::tx_account_email	
          :last_modified_by_email => import_hash[:modified_by_tx_account_email],
          # X.	Authentication_ | @Modified_By__tx_account_id::tx_account_status	
          :last_modified_by_status => import_hash[:modified_by_tx_account_status],
          # Y.	Vacancy ID
          :import_status => 1

        )
        @listing.save
      end
    end
    #puts csv.count
    ## Live = 1, Held = 2, Killed = 3
    Listing.temp_live.each do |listing|
      listing.update_attributes(:import_status => 3)
    end

    Industry.all.each do |industry|
      puts industry.title + " Active Listings: " + industry.listings.is_active.count.to_s
      industry.update_attributes(:listings_count => industry.listings.is_active.count)
    end

  end

# desc "Send Job Report to OnQ"
# task :send_jobs_report => :environment do
#   if Date.today.strftime("%a") != "Sat" && Date.today.strftime("%a") != "Sun"
#     ReportMailer.latest_jobs_report.deliver
#   end
# end
# 
# desc "Weekly Enquiries Report"
# task :send_enquiry_report => :environment do
#   if Time.now.strftime("%u") == "5" 
#     ReportMailer.enquiries_report.deliver
#   end
# end
# 
# desc "Weekly Enquiries Report"
# task :send_manual_enquiry_report => :environment do
#     ReportMailer.enquiries_report.deliver
# end
# 
# 




