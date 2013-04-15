#!/usr/bin/env perl
use Mojolicious::Lite;

helper get_file => sub {
  my ($c, $resource, $cb) = @_;

  # Create delay object
  my $delay = Mojo::IOLoop->delay(
    sub {
      my $delay = shift;

      # New request
      $c->ua->get($resource => $delay->begin);
#      return $c->ua->get($resource => $delay->begin);
    },
    sub {
      my ($delay, $tx) = @_;

      if (my $res = $tx->success) {
	$cb->($res->body) and return;
      };
      $cb->() and return;
    }
  );

  $delay->wait unless $delay->ioloop->is_running;
  return;
};

get '/' => sub {
  my $c = shift;
  my $res = $c->param('res') ||
    'https://gmail.com/.well-known/host-meta';

  return $c->get_file(
    $res => sub {
      my $data = shift;
      return $c->render_text($data || '[nodata]');
    }
  );
};

app->start;
