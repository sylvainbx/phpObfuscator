package Obfuscator;

use strict;
use fields 'var_connection',
		   'func_connection';

sub new {
	my ($class) = @_;
	my $this = fields::new($class);
	return $this;
}

 #
 # Generates a random ASCII character matching the following pattern [a-zA-Z0-9].
 # @param $user_lowercase if false, the generated characted will match the following pattern [A-Z0-9].
 #
sub gen_random_ascii_char {
	my ($self, $use_lowercase) = @_;
	die ('Missing parameter for Obfuscator::gen_random_ascii_char()') unless defined($use_lowercase);
	
	my $rand_num = 0;
	if ($use_lowercase) {
		do {
			$rand_num = int(0x30 + rand(0x4A));
		} while (($rand_num > 0x39 && $rand_num < 0x41) || ($rand_num > 0x5A && $rand_num <0x61));
	} else {
		do {
			$rand_num = int(0x30 + rand(0x2A));
		} while ($rand_num > 0x39 && $rand_num < 0x41);
	}
	return chr($rand_num);
}

 #
 # Generate a valid php random variable name
 #
sub gen_random_var_name {
	my ($self) = @_;
	
	my $var_name = '$_';
	for (my $i = 0; $i < 5; $i++) {
		$var_name .= $self->gen_random_ascii_char(1);
	}
	return $var_name;
}

 #
 # Generate a valid php random function name
 #
sub gen_random_func_name {
	my ($self) = @_;
	
	my $func_name = '_';
	for (my $i = 0; $i < 5; $i++) {
		$func_name .= $self->gen_random_ascii_char(0);
	}
	return $func_name;
}

 #
 # Given a variable name, return its coded equivalent; generating it, if it was not previsouly done.
 #
sub var_to_coded_name {
	my ($self, $var_name) = @_;
	die ('Missing parameter for Obfuscator::var_to_coded_name()') unless defined($var_name);
	
	if (!exists($self->{var_connection}->{$var_name})) {
		$self->{var_connection}->{$var_name} = $self->gen_random_var_name();
	}
	
	return $self->{var_connection}->{$var_name};
}

 #
 # Given a function name, return its coded equivalent; generating it, if it was not previsouly done.
 #
sub func_to_coded_name {
	my ($self, $func_name) = @_;
	die ('Missing parameter for Obfuscator::func_to_coded_name()') unless defined($func_name);
	
	if (!exists($self->{func_connection}->{$func_name})) {
		$self->{func_connection}->{$func_name} = $self->gen_random_func_name();
	}
	
	return $self->{func_connection}->{$func_name};
}

1;