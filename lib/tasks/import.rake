# This is a set of rake tasks used to import data into the production server.
 # Run `rake import:all` on the command line to import all available datasets,
 # and `rake import:teks` to only import TEKS data.

 require 'csv'

 namespace :import do

   task all: [:torn_2011] # add future tasks in here (CCRS, ELPS, etc.)

   task torn_2011: :environment do
     # standard = Standard.create title: 'catfish_trout'


       count = 0

      CSV.read('lib/assets/torn_1950-2013.csv', encoding: 'windows-1251:utf-8').to_a[0..-1].each do |line|
      if line[15].to_i != 0 && line[16].to_i != 0
        unless date = TornadoDate.where(year: line[1]).where(month: line[2]).find_by(day: line[3])
          date = TornadoDate.create(year: line[1], month: line[2], day: line[3])
        end

        hour = line[5].split(':')[0].to_i
        minute = line[5].split(':')[1].to_i

        if line[21].to_i == 1 || (line[21].to_i == 2 && line[22].to_i == 0)
          com_track = true
        else
          com_track = false
        end

        # com_track = (line[22] == 1) #Just in case the database doesn't like to read 1 as true and 0 as false

        Tornado.create(tornado_dates_id: date.id, f_scale: line[10], hour: hour, minute: minute, time_zone: line[6], state: line[7], injuries: line[11], fatalities: line[12], property_loss: line[13], crop_loss: line[14], start_lat: line[15], start_long: line[16], stop_lat: line[17], stop_long: line[18], distance: line[19], width: line[20], states_crossed: line[21], complete_track: com_track, segment_num: line[23], county_code_one: line[24], county_code_two: line[25], county_code_three: line[26], county_code_four: line[27])

      end
      # unless loc = Location.find_by(description: line[3])
      #   loc = Location.create(description: line[3], code: line[2])
      # end
      # unless t = When.where(year: line[6]).find_by(time_period: line[7])
      #   t = When.create(year: line[6], time_period: line[7])
      # end
      # unless comm = Commodity.find_by(description: line[1])
      #   comm = Commodity.create(description: line[1])
      # end
      # Sale.create(amount: line[8], unit: line[5], commodity_id: comm.id, when_id: t.id, location_id: loc.id)



       # LineItem.create standard_id: standard, grade: line[0], subject: line[1],
       #                 course: line[2], key: line[3], text: line[4], keywords: line[5]
       count += 1
     end
     puts "Added #{count} line-items for catfish_trout"
   end

 end

