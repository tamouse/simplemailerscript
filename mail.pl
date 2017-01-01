#!/usr/bin/perl -w
#
# mail - simple script to send mail
#
# Author: Tamara Temple <tamara@tamaratemple.com>
# Created: 2013-05-26
# Time-stamp: <2013-05-26 23:11:16 tamara>
# Copyright (c) 2013 Tamara Temple Web Development
# License: GPLv3
#

use strict;
use Email::Sender::Simple qw{sendmail};
use Email::Sender::Transport::Sendmail;
use Email::Simple;
use Email::Simple::Creator;
use Data::Dumper::Names;

my $transport = Email::Sender::Transport::Sendmail->new({
    sendmail => '/usr/bin/msmtp'
});

 
my $email = Email::Simple->create(
  header => [
    To      => 'Tamara Temple <tamouse@gmail.com>',
    From    => 'mail script <tamouse@comcast.net>',
    Subject => "a simple test",
  ],
  body => "This message is short, but at least it's cheap.\n",
);
 
print Dumper($email);


sendmail($email, { transport => $transport });
