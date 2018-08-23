ssh-keygen -t rsa -P '' -f id_rsa 
cat id_rsa.pub >> authorized_keys
chmod 0600 authorized_keys

cp -r . ../namenode/ssh
cp -r . ../datanode/ssh