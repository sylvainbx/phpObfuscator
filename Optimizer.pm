package Optimizer;

use strict;
use fields 'file';

 #
 # Build a new optimizer object, a valid file path must be specified 
 # ie. file exists, is not a directory, can be read & is not empty. Otherwise,
 # none of this object operations will run.
 #
sub new {
	my ($class, $file) = @_;
	die ('Missing parameter for Optimizer::new()') unless defined($file);
	
	my $this = fields::new($class);

	if (-e $file && -f $file && -r $file) {
		$this->{file} = $file;
	}
	return $this;
}

 #
 # In the specified file, remove any lines like "// bla bla" or "# bla bla"
 #
sub remove_single_line_comments {
	my ($self) = @_;
	
	if (defined($self->{file})) {
		my $text = '';
		if (open(FILE, "<$self->{file}")) {
			my $line = '';
			while (defined(my $line = <FILE>)) {
				# remove single line comment
				if ($line !~ m:^\s*(/{2,}|#):) {
					if ($line =~ m!(.*)(//|#)(?=(?:(?:[^"']*+['"]){2})*+[^"']*+\z)!) {
						$text .= $1;
					} else {
						$text .= $line;
					}
				}
			}
			close(FILE);
		}
		if (open(FILE, ">$self->{file}")) {
			print (FILE $text);
			close(FILE);
		}
	}
}

 #
 # In the specified file, remove any zones like "/* bla bla */" or "/* bla \n bla */"
 #
sub remove_comment_blocks {
	my ($self) = @_;
	
	if (defined($self->{file})) {
		my $text = '';
		if (open(FILE, "<$self->{file}")) {
			# put the file content to a single line scalar variable
			my @lines = <FILE>;
			foreach (@lines) {$text .= $_; }
			# remove comment blocks
			$text =~ s:/\*.*?\*/::gs;
			close(FILE);
		}
		if (open(FILE, ">$self->{file}")) {
			print (FILE $text);
			close(FILE);
		}
	}
}
 #
 # In the specified file, remove every spaces and carriages returns. The resulting file 
 # will be a single ligne, containing no multiple contiguous white spaces.
 #
sub remove_carriage_returns_and_trailing_spaces {
	my ($self) = @_;
	
	if (defined($self->{file})) {
		my $text = '';
		if (open(FILE, "<$self->{file}")) {
			my $line = '';
			while (defined($line = <FILE>)) {
				$line =~ s:\s+: :g;
				$text .= $line;
			}
			close(FILE);
		}
		if (open(FILE, ">$self->{file}")) {
			$text =~ s:\s+: :g;
			print (FILE $text);
			close(FILE);
		}
	}
}

1;