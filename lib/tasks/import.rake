# This is a set of rake tasks used to import data into the production server.
 # Run `rake import:all` on the command line to import all available datasets,
 # and `rake import:teks` to only import TEKS data.

require 'csv'

namespace :import do

  def data_model_addition(data_file, strength = -9)
    count = 0
    all_data = []
    error_count = 0

    #Setting up the array indices as their values in the line item
    cyclone_id = 0
    year = 1
    month = 2
    day = 3
    time = 5
    time_zone = 6
    state = 7
    f_scale = 10
    injuries = 11
    fatalities = 12
    property_loss = 13
    crop_loss = 14
    start_lat = 15
    start_long = 16
    stop_lat = 17
    stop_long = 18
    distance = 19
    width = 20
    states_crossed = 21
    complete_track = 22
    segment_num = 23
    county_code_one = 24
    county_code_two = 25
    county_code_three = 26
    county_code_four = 27
    corrected = -1


    CSV.read("lib/assets/" + data_file + ".csv", encoding: 'windows-1251:utf-8').to_a[0..-1].each do |line|
      if line[start_lat].to_i == 0 || line[segment_num].to_i == -9
        puts "Bad data skipped!"
      else
        all_data << line.concat([false]) if line[f_scale].to_i >= strength
      end
    end

    all_data.each_with_index do |line, index|
      unless line[corrected] == true

        if line[states_crossed].to_i == 1 && line[complete_track].to_i == 1 && line[segment_num].to_i == 1 #If the line is a 1,1,1, set it to fixed and set the complete_track to true
          line[complete_track] = true
          line[corrected] = true


        elsif line[states_crossed].to_i >= 2 && line[corrected] == false #If the tornado is part of a 2 segment track,
          segs = [index]  #Adds the line to an array of segments, more will be added as we search
          (index+1...all_data.length).each do |i| # Runs through the rest of the array looking for the other two segments
            if all_data[i][year] == line[year] && all_data[i][cyclone_id] == line[cyclone_id]
              segs << i  #Adds the other two segments to the segs array
            end
            break if all_data[i][year] > all_data[segs[0]][year]
          end
          # Puts the segment that contains the entire path data in the 0th index in the array
          segs.each do |segment|
            if all_data[segment][complete_track] == 0
              segs[0], segment = segment, segs[0]
              break
            end
          end
          #Set the complete track data correctly
          all_data[segs[0]][complete_track] = true  #Sets the complete track to true
          all_data[segs[0]][segment_num] = 1    #Sets the segment number to 1
          all_data[segs[0]][corrected] = true #Sets the entire path seg to fixed
          # Finds the second segment and saves the correct data to the all_data array
          (1...segs.length).each do |i|
            if all_data[segs[i]][start_lat] == all_data[segs[0]][start_lat]
              segs[1], segs[i] = segs[i], segs[1]
              all_data[segs[1]][complete_track] = false
              all_data[segs[1]][segment_num] = 1
              all_data[segs[1]][corrected] = true
              break
            end
          end

          if segs.length > 3
            (2...segs.length-1).each do |i|
              (i...segs.length).each do |j|
                if all_data[segs[i-1]][stop_lat] == all_data[segs[j]][start_lat]
                  segs[i], segs[j] = segs[j], segs[i]
                  all_data[segs[i]][complete_track] = false
                  all_data[segs[i]][segment_num] = i
                  all_data[segs[i]][corrected] = true
                  break
                end
                puts "We have a problem" if j = segs.length-1
                error_count += 1
              end
            end
          end

          all_data[segs[-1]][complete_track] = false
          all_data[segs[-1]][segment_num] = segs.length - 1
          all_data[segs[-1]][corrected] = true

        elsif line[states_crossed] == 3
          puts "Three state tornado, will add later"
        else
          # puts "Error with the path data!"
          # puts "#{index} has a "
        end
      end
    end

    puts "Total error count with multiple route data: #{error_count}"

    all_data.each do |line|
      if line[start_lat].to_i != 0 && line[start_long].to_i != 0
        unless date = CycloneDate.where(year: line[year]).where(month: line[month]).find_by(day: line[day])
          date = CycloneDate.create(year: line[year], month: line[month], day: line[day])
        end

        unless path = Path.where(states_crossed: line[states_crossed]).where(complete_track: line[complete_track]).find_by(segment_num: line[segment_num])
          path = Path.create(states_crossed: line[states_crossed], complete_track: line[complete_track], segment_num: line[segment_num])
        end
        hour = line[time].split(':')[0].to_i
        minute = line[time].split(':')[1].to_i

        Cyclone.create(cyclone_date_id: date.id, path_id: path.id, f_scale: line[f_scale], hour: hour, minute: minute, time_zone: line[time_zone], state: line[state], injuries: line[injuries], fatalities: line[fatalities], property_loss: line[property_loss], crop_loss: line[crop_loss], start_lat: line[start_lat], start_long: line[start_long], stop_lat: line[stop_lat], stop_long: line[stop_long], distance: line[distance], width: line[width], county_code_one: line[county_code_one], county_code_two: line[county_code_two], county_code_three: line[county_code_three], county_code_four: line[county_code_four])

      end
      count += 1
    end
    puts "Added #{count} tornados to the Storm model"
  end

  task all: [:year_1950_2013] # add future tasks in here (CCRS, ELPS, etc.)

  task year_2011: :environment do

    data_model_addition('torn_2011')

  end

  task year_1950_2013: :environment do

    data_model_addition('torn_1950-2013')

  end

  task only_5s: :environment do

    data_model_addition('torn_1950-2013', 5)

  end

end

