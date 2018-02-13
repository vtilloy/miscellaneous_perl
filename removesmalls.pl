#!/usr/bin/perl
use strict;
use warnings;

#from Vivek Krishnakumar (https://www.biostars.org/p/79202/)
#usage: perl removesmalls.pl 200 contigs.fasta > contigs-200_filtered.fasta

my $minlen = shift or die "Error: `minlen` parameter not provided\n";
{
    local $/=">";
    while(<>) {
        chomp;
        next unless /\w/;
        s/>$//gs;
        my @chunk = split /\n/;
        my $header = shift @chunk;
        my $seqlen = length join "", @chunk;
        print ">$_" if($seqlen >= $minlen);
    }
    local $/="\n";
}