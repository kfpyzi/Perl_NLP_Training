package Frequency;

use strict;
use warnings;
use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(_count);

use Data::Dumper;


sub _count{
    my $file = shift;
    print("file opened.\n");
    print("generating counts.\n");
    my @start = localtime();
    my %hCount;

    open(my $fh, ">", "freq.txt") or die $!;

    while(my $line = <$file>){
        chomp $line;
        my @aLine = split(" ", $line);
        for my $words(@aLine){
            $hCount{$words}++;
        }
    }


    for my $key (sort keys %hCount){
        print $fh "$key:$hCount{$key}\n";
    }    
    print("counts generated.\n");
    my @end = localtime();
    my $elapsed = ($end[0]-$start[0])/100;
    print("time elapsed: $elapsed\n");
}

1;
