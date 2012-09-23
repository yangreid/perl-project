#!/usr/bin/perl -w
use File::Copy;
use strict;
# version =1.0
# author reid
# this perl script is uesd to sync two folders
if(defined $ARGV[0] &&defined $ARGV[1]){
	my $sour = $ARGV[0];
	my $dest = $ARGV[1];
	my $start_time = time;
	sync($sour,$dest);
	my $duration = time()-$start_time;
	print STDOUT "The SYNC Execution time: $duration s\n";
}else
{
	usage();
}
sub usage
{
	print STDOUT "The usage of the $0 is :\n";
	print STDOUT "  You must give the source directory and destination directory\n";
	print STDOUT "  like perl $0 source destination!\n";	
}
sub getModifyTime
{
	my $file = shift ;
	my @attributes = stat($file);
	return $attributes[9];
}
sub mycopy
{
	my($source,$destination) = @_;
	print STDOUT "updating File :$source\n";
	copy($source,$destination);
}
sub sync{

	my($source,$destination) = @_;
	my $disk_handle;
	
	opendir($disk_handle,$source) or die "open dir fail!\n";

	unless(-e "$destination")
	{
		mkdir("$destination");
	}
	my @disk_content=readdir($disk_handle);
	closedir($disk_handle);
	foreach my $source_file (@disk_content) {
		unless($source_file eq '.'||$source_file eq '..'){	
			if(-f "$source/$source_file"){
				if(-e "$destination/$source_file"){
					my $source_file_modify_time = &getModifyTime("$source/$source_file");
					my $destination_file_modify_time = &getModifyTime("$destination/$source_file");
					if($source_file_modify_time > $destination_file_modify_time)
					{
						mycopy("$source/$source_file","$destination/$source_file");
					}
				}else{
					mycopy("$source/$source_file","$destination/$source_file");
				}	
			}
			if(-d "$source/$source_file"){
				##
				sync("$source/$source_file","$destination/$source_file");
			}
		}	
	}
	
}				

