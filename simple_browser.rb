require 'socket'
require 'json'

host = 'localhost'
port = 2000

puts "Welcome to the Simple Browser!"
puts "What would you like to do?"
puts "1 --> GET"
puts "2 --> POST"
action = gets.chomp

if action == "1"
	path = "/index.html"
	request = "GET #{path} HTTP/1.0\r\n\r\n"
elsif action == "2"
	path = "/thanks.html"
	puts "Viking Raid Registration:"
	puts "Please enter your name:"
	name = gets.chomp
	puts "Please enter your email address:"
	email = gets.chomp

	request_hash = {:viking => {:name=>name, :email=>email}}.to_json
	request = "POST #{path} HTTP/1.0\r\nFrom: #{email}\r\nUser-Agent: SimpleBrowser\r\nContent-Type: application/json\r\nContent-Length: #{request_hash.to_s.length}\r\n\r\n#{request_hash}"
else
	puts "I don't know that action"
	exit
end

socket = TCPSocket.open(host,port)					
socket.print(request)												# Send request to Server
response = socket.read											# Retrieve Server response
header,body = response.split("\r\n\r\n",2)  # Split response Header and Body
print body                                  # Print response Body
socket.close