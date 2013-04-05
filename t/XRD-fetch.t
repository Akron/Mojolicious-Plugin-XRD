#!/usr/bin/perl
use strict;
use warnings;

use lib '../lib';

use Test::More;
use Test::Mojo;
use Mojolicious::Lite;
use Mojo::JSON;

my $t = Test::Mojo->new;

my $app = $t->app;

$app->plugin('XRD');

# Silence
$app->log->level('error');

# my $xrd = $app->get_xrd('//gmail.com/.well-known/host-meta');
# my $xrd = $app->get_xrd('//yahoo.com/.well-known/host-meta');
# my $xrd = $app->get_xrd('//twitter.com/.well-known/host-meta');
# my $xrd = $app->get_xrd('//e14n.com/.well-known/host-meta');

diag $xrd->to_pretty_xml;

# $app->get_xrd('//gmail.com/.well-known/host-meta', -secure);

done_testing;

__END__
