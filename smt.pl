#!/usr/bin/perl
use strict;
use warnings;

open(my $fh, '<', $ARGV[0]) or die "data: $!\n";

my $FILE = \*$fh;
#_count($FILE);
print("###\n");
#_trainUnigram($FILE);
_testUnigram();
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
        print $fh "$key\t$hCount{$key}\n";
    }    
    print("counts generated.\n");
    my @end = localtime();
    my $elapsed = ($end[0]-$start[0])/100;
    print("time elapsed: $elapsed\n");
}

sub _trainUnigram{
    my %counts;
    my $total_count = 0;

    my $file = shift;
    print("file opened.\n");
    print("training unigram.\n");
    my @start = localtime();
    

    open(my $fhp, ">", "trainUnigram.txt") or die $!;

    while(my $line = <$file>){
        chomp $line;
        my @aLine = split(" ", $line);
        push @aLine, "</s>";
        foreach my $words (@aLine){
            $counts{$words}++;
            $total_count++;
            #print("$words:$counts{$words}\n");
        }

    }

    for my $key (sort keys %counts){
        my $probability = $counts{$key} / $total_count;
        #print($probability."\n");
        print $fhp "$key\t$probability\n";
    }    

    print("unigram trained.\n");
    my @end = localtime();
    my $elapsed = ($end[0]-$start[0])/100;
    print("time elapsed: $elapsed\n");

}

sub _testUnigram{
    open(my $fh, "<", "trainUnigram.txt");

    my %probabilities;

    while(my $line = <$fh>){
        chomp $line;
        my @aLine = split(/\t/, $line);
        $probabilities{$aLine[0]} = $aLine[1];
        
    }

    my $L = 0.95;
    my $LUNK = 1 - $L;
    my $V = 1000000;
    my $W = 0;
    my $H = 0;

    
    
}