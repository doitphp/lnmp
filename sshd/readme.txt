
一、生成SSH密钥

#ssh-keygen -t rsa

文件目录：.ssh
id_rsa 私钥(client)
id_rsa.pub 公钥(server)

二、配置文件

mv /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

sed -i 's/^#RSAAuthentication yes/RSAAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

service sshd restart


三、客户端
使用 id_rsa 私钥登陆