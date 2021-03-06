require "http/server"

class IndexHandler
	include HTTP::Handler

	def call(context)
		path : String = context.request.path

		if path[path.size - 1] == '/'
			index : String = ".#{path}index.html"

			if File.exists? index
				context.request.path = index
			end
		end

		call_next context
	end
end

def alive (
	directory : String = ".", # Directory path to serve files from.
	address : String = "127.0.0.#{Random::Secure.rand 255}", # Address to listen on.
	port : Int32 = Random::Secure.rand(1..65535), # Port to listen on.
	tls : Bool = false, # Whether to use TLS or not.
	key : String = "private.key", # Private key path.
	certificate : String = "certificate.crt", # Certificate chain path.
	directory_listing : Bool = true # Whether to enable directory listing or not.
)
	server : HTTP::Server = HTTP::Server.new [
		HTTP::ErrorHandler.new, # https://crystal-lang.org/api/1.0.0/HTTP/ErrorHandler.html
		HTTP::LogHandler.new, # https://crystal-lang.org/api/1.0.0/HTTP/LogHandler.html
		HTTP::CompressHandler.new, # https://crystal-lang.org/api/1.0.0/HTTP/CompressHandler.html
		IndexHandler.new,
		HTTP::StaticFileHandler.new(
			directory,
			directory_listing: directory_listing
		) # https://crystal-lang.org/api/1.0.0/HTTP/StaticFileHandler.html
	]
	protocol : String = "http"

	if tls == true
		context = OpenSSL::SSL::Context::Server.new
		context.private_key = key
		context.certificate_chain = certificate
		server.bind_tls address, port, context
		protocol = "https"
	else
		server.bind_tcp address, port
	end

	puts "directory: #{directory}"
	puts "alive at: #{protocol}://#{address}:#{port}"
	puts "directory listing: #{directory_listing}"
	server.listen # alive.
end
