#!/usr/bin/perl -w 

##
 # PHP Code Obfuscator
 #
 # @author sylvainbx
 # @version 1.0
 ##

BEGIN { srand() if $] < 5.004 }
$|++; # force autoflush

use strict;
use FileManager;
use Optimizer;
#use Obfuscator;

my $num_args = @ARGV;
if ($num_args < 1) {
	print "\nUsage: main.pl <php_code_folder> <...>\n";
	exit;
}

my $fm = FileManager->new();
my @files = ();

for my $arg (@ARGV) {
	if (-e $arg) {
		if (-f $arg) {
			push(@files, $arg);
		} elsif (-d $arg) {
			push(@files, $fm->get_files_list($arg));
		}
	} else {
		print "$arg is not a valid path\n";
	}
}

for my $file (@files) {
	if ($file =~ m/.php$/) {
		print "Processing $file...\n";
		my $op = Optimizer->new($file);

		$op->remove_single_line_comments();
		$op->remove_comment_blocks();
		$op->remove_carriage_returns_and_trailing_spaces();
	}
}
