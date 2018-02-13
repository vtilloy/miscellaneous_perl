
use Bio::SeqIO;
open OUT, ">/.../protein.fasta"; 

my $sequences = Bio::SeqIO->new( 
    -file   => "gL.fasta",
    -format => "fasta",
);

while ( my $dna = $sequences->next_seq ){
    my $protein = $dna->translate( 
        -codontable_id => 1, # standard genetic code
        -frame         => 0, #reading-frame offset 0
    );
    print OUT $dna->display_id, "\n";
    print OUT $protein->seq, "\n\n";
}
