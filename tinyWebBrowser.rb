require 'socket'
require 'json'

def request_type
	print "Type GET or POST as your request type: "
	input = gets.chomp
	get_or_post(input.upcase)
end

def get_or_post(input)
	if input == 'POST'
		create_Viking
	elsif input == 'GET'
		get_request
	end
end

def create_Viking
	print "What is your Viking name: "
	name = gets.chomp
	print "What is your email address: "
	email = gets.chomp
	@viking_hash = {:viking => {:name=>"#{name}", :email=>"#{email}"} }
	data = @viking_hash.to_json
	post_request(data)
end

def post_request(data)
	content_length = data.size
	request = "POST /Path/ HTTP/1.0\nFrom: dominik@gmail.com\nUser-Agent: TinyWebBrowser\nContent-Type: JSON\nContent-Length: #{content_length}\n#{data}\n"
	puts "sending request now"
	send_request(request)
end

def get_request
	path = "/index.html"
	request = "GET #{path} HTTP/1.0\nFrom: dominik@gmail.com\nUser-Agent: TinyWebBrowser\r\n"
	send_request(request)
end

def send_request(request)
	host = 'localhost'
	port = 2000
	socket = TCPSocket.open(host, port)
	socket.print(request)
	puts "This is the request: #{request}"
	response = socket.read
	
	body = response.split("\n")
	body.each { |line| puts line}
end

request_type

