#!/bin/sh
useradd ansible
mkdir -p /home/ansible/.ssh
usermod -aG docker,sudo ansible
chmod 0700 /home/ansible/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkrGpzlTH1D52b0Nwlmq7hSVBp2v7rtxOizusfuvZYZnva97z9j8DkBswIKsdVJhekS8l0gdHy5S04lmx+m5zlNQfT90aQogbiqVPvY/e/elv0mRkRnj6vDU5x7/L9ra5Mccd0zal697FZxSDH7g5tvChri8XLXc1b6dm3grFlaaCtMYHi57S5C+hvFsmEcCBmmYaA6iOqrD6Ar8P0Mw58RC2h7yt6NfQCDY4hFMbQE6LMgw600Cr3wGt993OcWjmH9t0PbeiIPgFUgZZYS6oFcNqLXuNQzbOwmwhQrqszCQY+vt6opJS0bI5jJctY7ckIjx9u5beBJe9+eswGd9Rz root@c3po' > /home/ansible/.ssh/authorized_keys
chmod 0600 /home/ansible/.ssh/authorized_keys
chown -R ansible /home/ansible
echo "ansible ALL=NOPASSWD: ALL" >> /etc/sudoers
