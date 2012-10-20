require 'ruby-growl'
require 'csv'    


csv_text = (File.read(ARGV[0]) rescue nil)
if(csv_text)
  puts "File:\t"+(ARGV[0])
else
  csv_text ||= "front side\tback side"
  puts "File:\t"+"nil"
end


csv = CSV.parse(csv_text, :headers => false)
length = ARGV[1] || csv.length
length = length.to_i
puts "Cards:\t"+length.to_s+"/"+csv.length.to_s


delay_in_seconds = ARGV[2] || 45
delay_in_seconds = [delay_in_seconds.to_i, 10].max
puts "Delay:\t"+delay_in_seconds.to_s+" seconds"

g = Growl.new "localhost", "ruby-growl"
g.add_notification "ruby-growl Notification"

loop do
  num = rand(length)

  tmp = rand(0)
  leftright = (tmp).round
  other = (1-tmp).round
  g.notify "ruby-growl Notification", "", csv[num][0].split("\t")[leftright]
  g.notify "ruby-growl Notification", "", csv[num][0] + "\n" + (num+1).to_s


  thing = (num+1).to_s + "\t" + csv[num][0].split("\t")[1] + "\t" + csv[num][0].split("\t")[0]
  puts thing + "\n"

  delay_in_seconds.times do
    sleep(1)
  end
  
end