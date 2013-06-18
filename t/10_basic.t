use strict;
use Test::More;

use HTTP::Headers;
use HTML::HeadParser::Liberal;

my $h = HTTP::Headers->new;
my $p = HTML::HeadParser->new($h);

$p->parse(<<EOT);
<head>
    <meta name="twitter:card" content="summary">
</head>
EOT

is $h->header('X-Meta-Twitter-Card'), 'summary';

done_testing;