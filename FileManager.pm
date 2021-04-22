package FileManager;

use strict;
use fields;

sub new {
	my ($class) = @_;
	my $this = fields::new($class);
	return $this;
}

 #
 # return the list of files inside the specified directory (recursively)
 #
sub get_files_list {
	my ($self, $path) = @_;
	die ('Missing parameter for FileManager::get_files_list()') unless defined($path);
		
	my @FilesList = ();

	# read files list
	opendir (my $FhRep, $path)
		or die "Unable to open directory: $path\n";
		
	my @Content = grep { !/^\.\.?$/ } readdir($FhRep);
	closedir ($FhRep);

	foreach my $fileFound (@Content) {
		# processing files
		if ( -f "$path/$fileFound") {
			push ( @FilesList, "$path/$fileFound" );
		}
		# processing directories
		elsif ( -d "$path/$fileFound") {
			push (@FilesList, $self->get_files_list("$path/$fileFound") );
		}
	}
	return @FilesList;
}


1;