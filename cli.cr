require "./alive"
require "option_parser"

directory : String = "." # Current working directory.
address : String = "127.0.0.#{Random::Secure.rand 255}" # Random IP address (127.0.0.x).
port : Int32 = Random::Secure.rand 1..65535 # Random port (1-65535).
tls : Bool = false # Do not use TLS by default.
key : String = "private.key" # Private key path.
certificate : String = "certificate.crt" # Certificate chain path.
directory_listing : Bool = true # Enable directory listing by default.

parser = OptionParser.parse do |parser|
	parser.banner = "Usage: #{PROGRAM_NAME} [arguments (optional)]"

	parser.on "-h", "--help", "Displays helpful information." do
		puts parser
		exit
	end

	parser.on "-d <path>", "--directory=<path>", "Set the directory path to serve files from. Default: #{directory}" { |d| directory = d }
	parser.on "-a <address>", "--address=<address>", "Address to listen on. Default: random (127.0.0.x)" { |a| address = a }
	parser.on "-p <port>", "--port=<port>", "Port to listen on. Default: random (1-65535)" { |p| port = p.to_i }
	parser.on "-t", "--tls", "Enable TLS. Default: #{tls}" { tls = true }
	parser.on "-k <path>", "--key=<path>", "Set the private key path. Default: #{key}" { |k| key = k }
	parser.on "-c <path>", "--certificate=<path>", "Set the certificate chain path. Default: #{certificate}" { |c| certificate = c }
	parser.on "-l", "--directory-listing", "Disable directory listing. Default: #{directory_listing}" { directory_listing = false }

	parser.invalid_option do |flag|
		puts "ERROR: #{flag} is not a valid option."
		puts parser
		exit
	end
end

parser.parse # Parse out all given arguments.
alive directory, address, port, tls, key, certificate, directory_listing # alive.
