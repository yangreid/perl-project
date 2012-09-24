#!/usr/bin/perl
sub func1 {
	my $value = shift;
    #print "func1 is running\n";
	print "The file name : $value\n";
}
sub func_test {
    my $func_ref = shift;
    # ref will return 'CODE' if it's function reference
    if ( ( ref($func_ref) eq "CODE" )
        && defined( &{$func_ref} ) )
    {
        &{$func_ref}("hello");
        print $@ if $@;
    }
    else {
        print "Not real function was called! \n";
    }
}
## testing from here
my $func_ref = \&func1;
my $anoy_ref = sub { print "anonymous function is running\n" };
my $var      = "abcd";
my $var_ref  = \$var;
func_test($func_ref);
func_test($anoy_ref);
func_test($var);
func_test($var_ref);
recursion("/home/Administrator/workspace/git_demo/perl_fork1/",$func_ref);
sub recursion{
	my ($folder,$function_ref) = @_;
	
	#������û����������һ�¸�ʽ��
	chomp $folder;
	if ($folder !~ /[\/\\]$/)
		{
			$folder = $folder."/";
		}
	#��֤һ����Ч��
	if (!(-d $folder))
		{
			die "Oooops that is not a folder!!\n";
		}
	if ( ( ref($function_ref) eq "CODE" )
        && defined( &{$function_ref} ) )
    {
        &{$function_ref}("hello world");
        print $@ if $@;
    }
	#�����Ƕ�Ŀ¼���б���
	push (my @dirs,$folder);
	while (@dirs) {
		#$rcdir is Recent Dir
		my $rcdir = shift @dirs;
		opendir DIR,$rcdir or die "Cant open Dir :$!\n";
		while (my $name = readdir DIR)
		{        
			#print $filename."\n";
			if ($name!~ /\.?\.$/)
			{
				 my $filename = $rcdir.$name;
				 #������ļ��Ļ�������Hash������д�ļ�
				 if(-f $filename)
				 {
					#��������Ǹո����ɵ�md5�ļ����ͽ��д�������ֱ�����ӵ��ͺ���
					if($filename !~ /\.md5$/)
					{
					&{$function_ref}($filename);
					#print "Now hashing $filename\n";
					#my $hashvalue = &md5hash ($filename);
					#������ļ�
					#open (MD5FILE,">$filename".".md5");
					#print MD5FILE $hashvalue;
					#close MD5FILE;
					#print "Complete!\n";
					}
				 }
				 #������ļ��У���ô���������еȴ�������
				 else
				 {                    
					push (@dirs,$filename."/");
				 }
			}
		}
	}
}