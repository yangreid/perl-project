#!/usr/bin/perl
use File::Copy;
use File::Copy qw(cp);

use warnings;
my $disk_handle;
my $mobi_disk_handle;
opendir($disk_handle,"E:\\public\\1") or die "open dir fail!\n";
opendir($mobi_disk_handle,"E:\\public\\2") or die "open dir fail!\n";
my @disk_content=readdir($disk_handle);
my @mobi_disk_content=readdir($mobi_disk_handle);
chdir("E:\\public\\1");
my @diff;
foreach my $tmp (@disk_content) {
        foreach my $tmp2 (@mobi_disk_content) {
                if($tmp eq $tmp2){
                        $count++;
                }
        }
        if($count eq 0){
                push(@diff,$tmp);
        }
        $count=0;
}
print "you have these files must to sycn:\n";
foreach my $dic (@diff) {
        print "+++++>$dic\n"
}
foreach my $copy (@diff) {
        if (-f $copy) {
                copy("E:\\public\\1\\$copy","E:\\public\\2\\$copy");
        }
        if(-d $copy){
				print "!!!!";
				system("xcopy",$copy,"E:\\public\\2\\$copy\\","/S");
        }

}
print "syn is over\n";
