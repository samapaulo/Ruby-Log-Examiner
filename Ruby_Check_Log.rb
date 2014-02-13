#! /usr/bin/env ruby

##############################
#			           #
# check_log.rb	           #
#                            #
# Check log file for Error   #
# statement(s)               #
##############################

require 'net/smtp'
require 'mail'

count=0

if File.exists?(ARGV.first)
      # Look for 'ERROR' at the start of lines
              File.open(ARGV.first).each_line do |line| 
                   count += 1   if(line[/^ERROR/])

              end
end


# If the log file has ERROR statments, the file is sent to a select recipient 

if count>0

 Mail.defaults do
  smtp '127.0.0.1' # Port 25 default
 end

# the mailer 

 mail = Mail.new do
      from 'me@domain.com'
        to 'you@domain.com'
   subject 'This log contains ERROR checks'
      body File.read(ARGV.first)
      add_file {:filename => 'Log_With_Error_Statements', :data => File.read(ARGV.first)}
 end

 mail.deliver!

end
