use Digest::MD5;
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
 my $hash_value = md5hash("./reid");
 print $hash_value;

