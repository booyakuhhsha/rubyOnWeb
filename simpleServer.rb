require 'socket'
require 'json'

def return_file(file,client)
  text = File.open(file, 'r')
  text.each_line { |line| client.puts line }
end

def file_length(file)
  text = File.open(file, 'r')
  text.size
end


server = TCPServer.open(2000)
loop {
	client = server.accept
	request = client.gets
	verb = request.split(" ")
	file = verb[1].split("/")[1]
	if verb[0] == 'GET'
	  if File.exists?(file)
	    status = "200"
	    client.puts "#{verb[2]} #{status} OK\nDate: #{Time.now.ctime}\nContent-Type: text/html\nContent-length: #{file_length(file)}\n\n" 
	    body_of_file = return_file(file,client)
	  else
	  	client.puts "File is not found"
	  	status = "404"
	  end
	elsif verb[0] == 'POST'
		from = client.gets
		user_agent = client.gets
		content_type = client.gets
		content_length = client.gets
		data = client.gets
		json_data = JSON.parse(data)
		client.puts "We got our POST request! and here is the data: "
		client.puts json_data
	end
	client.close
}