# alive
Static file server written in [Crystal](https://crystal-lang.org).

## About
**alive** is a fast, secure, efficient and easy to use static file server.
It can both be used as a library and a CLI program.
The purpose of **alive** is to make static website development faster and without a hassle.
It follows the [Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy), *"do one thing and do it well"*.
Out of the box, **alive** allows you to customize every option it has.

## Reasons to use alive
- Secure by default.
- Both HTTP and HTTPS support.
- Lightweight and well-documented code.
- Easily portable and customizable.
- Performant.

## CLI usage
1. Clone the repository like so: `git clone https://github.com/often/alive.git`
2. Enter the directory: `cd alive`
3. Build `cli.cr` using: `crystal build -o alive --release cli.cr`
4. Run the program like so: `./alive`
5. This will start a static file server with all the default options set.
6. You can of course customize how the server will behave using program arguments. It is optional, but you may want to look at what features it offers. To do that simply run `./alive -h` or `./alive --help`
7. Here's an example of what the output would look like:
```
Usage: ./alive [arguments (optional)]
    -h, --help                       Displays helpful information.
    -d <path>, --directory=<path>    Set the directory path to serve files from. Default: .
    -a <address>, --address=<address>
                                     Address to listen on. Default: random (127.0.0.x)
    -p <port>, --port=<port>         Port to listen on. Default: random (1-65535)
    -t, --tls                        Enable TLS. Default: false
    -k <path>, --key=<path>          Set the private key path. Default: private.key
    -c <path>, --certificate=<path>  Set the certificate chain path. Default: certificate.crt
    -l, --directory-listing         Disable directory listing. Default: true
```

## Library usage
1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
    alive:
        github: often/alive
```
2. Run `shards install`
3. That's it. You may now use it like so:
```crystal
require "alive"

alive # Starts a static file server with all the default options set.
alive tls: true, key: "/path/to/private.key", certificate: "/path/to/certificate.crt" # Starts a static file server with TLS enabled.
alive directory_listing: false # Starts a static file server with directory listing disabled.
# and so on.
```

## Other
If it is a public website you are hosting with **alive** I recommend that you enable TLS. You can get a free TLS certificate from [Let's Encrypt](https://letsencrypt.org).
You may also generate a self-signed TLS certificate if it is a local development server you are running.
For additional security steps you might want to disable directory listing.
After building `cli.cr` you may want to setup an alias in your `.bashrc` for ease of access. I did it like so: `alias alive="/path/to/alive"`

## License
[0BSD](LICENSE)
