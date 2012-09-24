#! perl -w

use strict;
use Digest::MD5;
#��ʾ�û�������Ҫ����Hash���ļ���
print "Please input the full path of your FTP folder:\n";
my $folder = <STDIN>;
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
				print "Now hashing $filename\n";
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

########################
#�����ļ���MD5ֵ       #
#�������������ļ�·��  #
#���أ�MD5ֵ           #
########################
sub md5hash
{
    #ȡ�ò���
    my $hashfile=shift;
    #���ļ�
    open FILE,$hashfile or print "Can't open $hashfile:$!\n";
    #�����ƴ��ļ�
    binmode FILE;
    #����MD5����
    my $md5 = Digest::MD5->new;
    $md5->addfile (*FILE);
    my $hashval=$md5->hexdigest;
    #�ر��ļ�
    close FILE;
    #����MD5ֵ
    return $hashval;
}



