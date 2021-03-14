#!/bin/sh
useradd ansible
mkdir -p /home/ansible/.ssh
usermod -aG docker ansible
chmod 0700 /home/ansible/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJlor4Jmv+69g+nm5CczVKBrHTiKlUtBUrH6vxo2YfYn+wc6Gj30gRi5tk+P2o0yQV8xhMGbKHmh5i8aYkDMFxe/BMDtUr3lFoTAV3vc2wUN6q0uBvSbd6s15vFsUilDE7/yMOolei7jOZQPqixqdf0BPH2tnI2prXs+pUl3HkAV8bWuEZwa3Vybve06r1eAc5BZYICv0JperQUAfE8WfpJxUfh5vAT+1Aa+kun8eYB434oTCbCWvoWamSeeI1XtX2wpksEt3viavi5f4hiV1fYkxBiNLGtxHQrllosb9Y+xM9qB/cPrxS2JzIhnhrNSPmjXmFc+7l4t++TTA0LjhT tiago@c3po' > /home/ansible/.ssh/authorized_keys
chmod 0600 /home/ansible/.ssh/authorized_keys
chown -R ansible /home/ansible
