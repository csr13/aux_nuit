### How to pipe localhost from one machine to other using ssh

`ssh -L [local host]:[local port]:[remote host]:[remote port] [user]@[host]`

Example, have one http server application running on localhost and port 8000 on the machine I am connecting to,
and the application server is running without authentication, don't want to deal with nginx authentication or some other sort of thing:

`ssh -L 127.0.0.1:8888:127.0.0.1:8000 localadmin@111.11.11.1`

I open my browser on 127.0.0.1:8888 and I see the application running on my local, I check the ssh connection terminal to verify connection is being tunneled.

Generate ssh keys for a user

```bash
mkdir .ssh
chmod 700 .ssh
cd .ssh
ssh-keygen -f id_rsa -t rsa -N ''
chmod 600 '/home/<user>/.ssh/'*
cp id_rsa.pub /tmp/<user>.id_rsa.pub
cp id_rsa /tmp/<user>.id_rsa
cp id_rsa.pub authorized_keys
```
