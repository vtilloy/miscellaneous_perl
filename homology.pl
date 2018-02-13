#!/usr/bin/perl

#retirer les reads matchant en double, avec le plus fort nombre de variants (NM)

use strict;
use List::Util qw(sum);

my $input = shift;
my $NM = 0;
my $sum_read_identique = 0;
my $reads = 0;

open IN, "<$input" || die "probleme ouverture";

while (<IN>)
{
	if (/(\S+)\t(\S+)\t(\S+)\t(\S+)\t(\S+)\t(\S+)\t(\S+)\t(\S+)\t(\S+)\t(\S+)\t(\S+)\t(\S+)/)
	{
		my $cigar = $6;
		my $NM_txt = $12;
		my $flag = $2;
		if ($2 != 4)
		{
			$reads++;
			if ($NM_txt =~ /NM.i.(\d+)/)
			{
				$NM = $1;
			}
			my $sum_delins = comptage($cigar);
			my $snp = $NM - $sum_delins;
			
			if ($snp == 0)
			{
				$sum_read_identique++;

			}
		}
	}
}

close IN;

print "$input\t$reads\t$sum_read_identique\n";

sub comptage
{
	my $cigar = $_[0];

	my @del = ($cigar =~ /\d+D/g);foreach (@del){$_ =~ tr /D//d;}
	my $somme_del = sum(@del);
	my @ins = ($cigar =~ /\d+I/g);foreach (@ins){$_ =~ tr /I//d;}
	my $somme_ins = sum(@ins);
	return ($somme_del+$somme_ins);
}
