#!/usr/bin/perl

#A partir d'un fichier txt issu nt blast de contigs (et filtré pour v), associer pour chaque contig les resultats sur une seule ligne

 
use strict;
use warnings;

open IN, "/.../v82.txt" || die "probleme ouverture";
open OUT, ">/...Formev82.txt" || die "probleme ouverture";


my (@queries, %viruses);
my $count;
 
while (my $line = <IN>) {
	chomp $line;
	if ($line =~ /^Query= project_mid\s?(\d+)/) {
	    $count = $1;
		$queries[$count] = $line;
	} else {
		next unless $line =~ /^gb/;
		$line =~ s/[-\d+\.\sEe]+$//; # suppression des "scores" en fin de ligne
		
		push @{$viruses{$line}}, $count;
	}
}}

close IN;
close OUT;