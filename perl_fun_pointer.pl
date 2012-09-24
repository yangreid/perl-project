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
	
	#下面对用户的输入进行一下格式化
	chomp $folder;
	if ($folder !~ /[\/\\]$/)
		{
			$folder = $folder."/";
		}
	#验证一下有效性
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
	#下面是对目录进行遍历
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
				 #如果是文件的话，进行Hash，并且写文件
				 if(-f $filename)
				 {
					#如果它不是刚刚生成的md5文件，就进行处理，否则直接无视掉就好了
					if($filename !~ /\.md5$/)
					{
					&{$function_ref}($filename);
					#print "Now hashing $filename\n";
					#my $hashvalue = &md5hash ($filename);
					#输出到文件
					#open (MD5FILE,">$filename".".md5");
					#print MD5FILE $hashvalue;
					#close MD5FILE;
					#print "Complete!\n";
					}
				 }
				 #如果是文件夹，那么放入数组中等待遍历。
				 else
				 {                    
					push (@dirs,$filename."/");
				 }
			}
		}
	}
}