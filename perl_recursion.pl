#! perl -w

use strict;
use Digest::MD5;
#提示用户输入需要进行Hash的文件夹
print "Please input the full path of your FTP folder:\n";
my $folder = <STDIN>;
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
				print "Now hashing $filename\n";
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

########################
#计算文件的MD5值       #
#参数：完整的文件路径  #
#返回：MD5值           #
########################
sub md5hash
{
    #取得参数
    my $hashfile=shift;
    #打开文件
    open FILE,$hashfile or print "Can't open $hashfile:$!\n";
    #二进制打开文件
    binmode FILE;
    #进行MD5计算
    my $md5 = Digest::MD5->new;
    $md5->addfile (*FILE);
    my $hashval=$md5->hexdigest;
    #关闭文件
    close FILE;
    #返回MD5值
    return $hashval;
}



