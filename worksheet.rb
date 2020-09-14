########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.
# Which layers are nested in each other?
# Which layers of data "have" within it a different layer?
# Which layers are "next" to each other?

########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have

########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:
# - the number of rides each driver has given
# - the total amount of money each driver has made
# - the average rating for each driver
# - Which driver made the most money?
# - Which driver has the highest average rating?

ride_log = { DR0004: [["3rd Feb 2016",5,"RD0022",5],
                      ["4th Feb 2016",10,"RD0022",4],
                      ["5th Feb 2016",20,"RD0073",5],
                      ["5th Feb 2016",45,"RD0003",2]],

             DR0001: [["3rd Feb 2016",10,"RD0003",3],
                      ["3rd Feb 2016",30,"RD0015",4],
                      ["5th Feb 2016",45,"RD0003",2]],

             DR0002: [["3rd Feb 2016",25,"RD0073",5],
                      ["4th Feb 2016",15,"RD0013",1],
                      ["5th Feb 2016",35,"RD0066",3]],

             DR0003: [["4th Feb 2016",5,"RD0066",5],
                      ["5th Feb 2016",50,"RD0003",2]]
}

ride_log = ride_log.sort.to_h #orders & assigns according to key

def sum(array)
  array.inject(0){|sum,x| sum + x }
end

def to_dollars(num)
  "$#{'%.2f' % num}"
end

def rides_each_driver(log)
  big_array = ["RIDES GIVEN:\n\n"] #first item, bc I'm printing this first/as a header

  log.each do |driver_id, nested_ride_info|
    dr_id_w_tot_earned = []
    dr_id_w_tot_earned << "Driver: #{driver_id}"
    dr_id_w_tot_earned << "Total rides: #{nested_ride_info.length}\n\n"
    big_array << dr_id_w_tot_earned
  end
  return big_array
end


def total_each_driver(log)
  big_array = ["\nDRIVER EARNINGS:\n\n"]

  log.each do |driver_id, nested_ride_info|
    dr_id_w_tot_earned = []
    dr_id_w_tot_earned << "Driver: #{driver_id}"

    total_earned = sum(nested_ride_info.map {|column| column[1].to_f})
    dr_id_w_tot_earned << "Total earned: #{to_dollars(total_earned)}\n\n" #https://stackoverflow.com/questions/11688466/select-all-elements-from-one-column-in-an-array-of-arrays-in-ruby
    big_array << dr_id_w_tot_earned
  end
  return big_array
end


def avg_rating_each_driver(log) #average to be computed & outputted as a float
big_array = ["\n\nAVERAGE RATINGS:\n\n"]

log.each do |driver_id, nested_ride_info|
  dr_id_w_tot_earned = []
  dr_id_w_tot_earned << "Driver: #{driver_id}"
  average = sum(nested_ride_info.map {|column| column[3].to_f}) / (nested_ride_info.length) #computes average: gets total of ratings, div by no. of rides
  dr_id_w_tot_earned << "Average rating: #{average}\n\n"
  big_array << dr_id_w_tot_earned
end
return big_array
end


def highest_earners(log)
  big_array = []

  log.each do |driver_id, nested_ride_info|
    dr_id_w_tot_earned = []
    dr_id_w_tot_earned << driver_id
    dr_id_w_tot_earned << sum(nested_ride_info.map {|column| column[1]})
    big_array << dr_id_w_tot_earned

  end
  max_earned = big_array.map(&:last).max

  highest_earner_arr = big_array.each do |dr_id_w_tot_earned, index|
    dr_id_w_tot_earned[index] == max_earned #picks up any ties :)
  end #nested array that holds array w paired info for any max earners

  outputs = ["\nHIGHEST EARNER(S):\n\n"]

  highest_earner_arr.each_with_index do |high_earner, index|
    outputs << "Driver #{high_earner[0]} => #{to_dollars(high_earner[1])}"  #might have to move to_dollars() (not sure how the original values being foat instaed might change the equivalency on line  )
  end
  return outputs
end


def highest_rated_drivers(log)
  big_array = []

  log.each do |driver_id, nested_ride_info|
    dr_id_w_avg_rating = []
    dr_id_w_avg_rating << driver_id

    average = sum(nested_ride_info.map {|column| column[3].to_f}) / (nested_ride_info.length)
    dr_id_w_avg_rating << average

    big_array << dr_id_w_avg_rating
  end

  max_avg_rating = big_array.map(&:last).max

  highest_rated_arr = big_array.select.with_index do |dr_id_w_avg_rating, index|
    dr_id_w_avg_rating[1] == max_avg_rating
  end

  outputs = ["\nHIGHEST RATED DRIVER(S):\n\n"]

  highest_rated_arr.each_with_index do |high_rated, index|
    outputs << "Driver #{high_rated[0]} => Avg. #{high_rated[1]}\n\n"
  end
  return outputs
end

puts "\n\n---WELCOME TO THE RIDE SHARE LOGGER---\n\n"
puts rides_each_driver(ride_log)
puts total_each_driver(ride_log)
puts highest_earners(ride_log)
puts avg_rating_each_driver(ride_log)
puts highest_rated_drivers(ride_log)


#https://stackoverflow.com/questions/30528128/ruby-turn-a-nested-array-into-a-hash
#https://stackoverflow.com/questions/32521066/how-can-i-find-the-max-value-from-an-array-of-arrays
