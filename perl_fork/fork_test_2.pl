#!/usr/bin/perl
#------------------------------------
# fork-test.pl
print "Program started, pid=$$.\n";
if ($child_pid = fork()) {
	print "I'm parent, my pid=$$, child's pid=$child_pid.\n";
	waitpid($child_pid,0);
} else {
	print "I'm child, pid=$$.\n";
	sleep 10;
	exec("date");	
}###
