#!/usr/bin/perl -w

### Credit for this script goes to David Simmons-Duffin (http://davidsd.org/about/)
### See http://davidsd.org/2010/03/the-snarxiv/ for more details.
### It compiles code for OCAML using a context-free grammar definition file.
### Run, for example, ./compile-grammar.pl patentTitle.gram to create the OCAML code, and then
### run: ocamlc -o title patentTitle.ml to generate an executable.

($gram) = @ARGV;

unless ($gram) {
print <<"EOF";
usage: cgram grammar output
notes: If the output file is "foo", then the ocaml code will be
       written into "foo.ml". Make sure the ocaml compiler "ocamlopt"
       is present on this system.
EOF
    exit 0;
}

unless($gram =~ /^\w*\.gram$/) {
    print "input should be a .gram file\n";
    exit 1;
}

$gram =~ /^(\w*)\.gram$/;
$out = $1;

open GRAM, "$gram";
open OUT, ">$out.ml";

print OUT <<'EOF';
type phrase = Str of string | Opts of phrase array array

let _ = Random.self_init ()

let randelt a = a.(Random.int (Array.length a))
let rec print phr = match phr with
  Str  s       -> print_string s
| Opts options ->
    let parts = randelt options in
    Array.iter print parts

(* Grammar definitions *)
EOF

undef $/;
@entries = split(/\s* ^ \s* (?= \S+\s* ::=)/mx, <GRAM>);
close GRAM;

undef $mainphrase; # the goal of the grammar. i.e. the thing we'll be producing

print "parsing grammar '$gram' into '$out.ml'...";
foreach (@entries) {
    s/\s* \# .* $//xmg;
    if (/\s*(\S*)\s*::=\s*(.*)/s) {
        $lhs = $1;
        $rhs = $2;

        if (!defined ($mainphrase)) {
            $mainphrase = $lhs;
            print OUT "let rec $lhs = Opts [|\n";
        } else {
            print OUT "and $lhs = Opts [|\n";
        }

        @opts = split(/\s*\|\s*/, $rhs);
        foreach $opt (@opts) {
            print OUT "  [|";
            $opt =~ s/\s*\n\s*/ /g;

            # split just before < and after >
            @parts = split(/ (?= <) | (?<= >) /x, $opt);
            foreach $part (@parts) {
                if ($part =~ /<(.*)>/) { # it's either a grammar part
                    print OUT " $1;";
                } else {                 # or a string literal
                    $part =~ s/\\/\\\\/g; # turn \ into \\ for ML printing
		    $part =~ s/\"/\\\"/g; # likewise for "
                    print OUT " Str \"$part\";";
                }
            }
            print OUT "|];\n";
        }
        print OUT "|]\n\n";
    } else {
        if (/\S/) {
            print "********error parsing*******";
            close OUT;
            exit 1;
        }
    }
}
print "done.\n";

print OUT "let _ = print $mainphrase\n";
print OUT "let _ = print_string \"\\n\"";
close OUT;
