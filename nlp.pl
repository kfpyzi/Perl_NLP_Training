
use strict;
use warnings;

use Frequency;

exit main();

sub main{
    frq();
    return 0;
}

sub frq{
    open(my $fh, '<', $ARGV[0]) or die "data: $!\n";
    _count(\*$fh);
}