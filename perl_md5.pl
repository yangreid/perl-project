use Digest::MD5;
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
 my $hash_value = md5hash("./reid");
 print $hash_value;

