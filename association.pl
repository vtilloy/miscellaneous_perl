#!/usr/bin/perl

# association cluster, sequence et nombre de matchs (attention : pas dans le meme ordre dans 2 fichiers)

use strict;
use warnings;
 
my %tab;
open OUT, ">/.../.../file.csv"; 
open(my $fh, 'file2.txt') or die "impossible d'ouvrir le fichier2";
while (<$fh>) {
   if ($_ =~ /fasta(\d+)$/) {
      my $l = <$fh>;
      chomp $l;
      $tab{$1} = $l;
   }
}
close($fh);
 
open($fh, 'file1.fasta') or die "impossible d'ouvrir le fichier1";
while (<$fh>) {
   if ($_ =~ /^>Cluster(\d+)/) {
      my $l = <$fh>;
      chomp $l;
      print OUT "Cluster" . $1 . " " . $l . " " . $tab{$1} . "\n";     
   }
}
close($fh);
