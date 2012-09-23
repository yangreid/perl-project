#!/usr/bin/perl -w

use strict;
use File::Find;

my $path = '.';
sub wanted {
    if ( -f $File::Find::name ) {
        if ( $File::Find::name =~ /\.old$/ ) {
            print "$File::Find::name\n";
			my $destination_file_modify_time = getModifyTime($File::Find::name);
			print $destination_file_modify_time;
        }
    }

}
find (\&wanted,$path);
sub getModifyTime
{
	my $file = shift ;
	my @attributes = stat($file);
	return $attributes[9];
}