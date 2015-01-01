package HTML::HeadParser::Liberal;
use 5.008005;
use strict;
use warnings;
use HTML::HeadParser;
use B::Deparse;

our $VERSION = "0.01";

BEGIN {
    my $code = "sub " . B::Deparse->new->coderef2text(\&HTML::HeadParser::start);
    $code =~ s/(if \(\$\$attr{'name'}\) {)/$1 \$attr->{name} =~ s\/:\/_\/g;/gsm;

    no warnings 'redefine';
    *HTML::HeadParser::start = eval $code;
}

1;
__END__

=encoding utf-8

=head1 NAME

HTML::HeadParser::Liberal - More Liberal HTML Head Section Parsing

=head1 SYNOPSIS

    use HTML::HeadParser::Liberal;

=head1 DESCRIPTION

HTML::HeadParser::Liberal is an evasive module that patches HTML::HeadParser
directly (and globally) so that workarounds for certain quirks are enabled.

Currently this module supposrts the following:

=over 4

=item Meta names passed to HTTP::Headers are munged

Currently all ":"'s are converted to a hyphen, so things like 

    <meta name="twitter:card" ...>

doesn't choke, and you can access this value from HTTP::Headers like

    $h->header('X-Meta-Twitter-Card');

Note that YOU DO NOT NEED THIS HACK if you're using a recent enough LWP.
Because of this I was initially going to let this module die a slow death,
but then I have since been told that there are environments stuck with old
modules, so I guess there are some situations where this module is still
useful.

=back

=head1 LICENSE

Copyright (C) Daisuke Maki.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Daisuke Maki E<lt>lestrratE<gt>

=cut

