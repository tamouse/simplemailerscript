# Simplemailer

A really simple mailer command line script that sort of emulates mail(1)

## Installation

    $ gem install simplemailer

## Usage

Get help for simplemailer by typing:

    $ simplemailer --help
	
Send a mail:

    $ cat msgbody.txt | simplemailer recipient@example.com

## Synopsis

    $ simplemailer [OPTIONS] to...
	
## Options

`--from EMAIL`:: Email address to use in the From: field of the message.

`--subject TEXT`:: Text is used in the Subject: field of the message.

`--body TEXT`:: Text is used for the body of the message. If this is
omitted, the body is read from STDIN.

`--debug`:: Flag that puts the program in debug mode

`--log-level`:: Level of logging for the program. Default is
`info`. Setting the `--debug` flag also sets the logging level to
`debug`. (Note that the opposite is NOT true.)


## Configuration

`simplemailer` reads a configuration file from
`$HOME/.simplemailer.rc`. Configuration is in YAML form. The following
items can be configured:

`transport:`:: a path to the sendmail transport of your choosing.

`from:`:: the user mail is sent from by default.

`subject:`:: default subject to use in messages.

`body:`:: default body to use in messages.

`debug:`:: turn on/off debugging initially. Overridden by `--debug`
flag on command line.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
