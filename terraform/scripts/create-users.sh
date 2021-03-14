#!/bin/sh
useradd ansible
mkdir -p /home/ansible/.ssh
usermod -aG docker ansible
chmod 0700 /home/ansible/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCGF3RqxuzW0uJcKsgQ8ygrRqEqkaJmK+fZifiHdXf/4HKZh7EO17fPsMIoJPnjIpVDDaxQN3KqRKfY5lGIag11bfxE9lQ3qE0YuOXKP9u2X2OQeNFE8MTfgNyInSH7y8Fhn/OB3nQqfyleVYTxKoWXJkLa/1uNpFwbKE5Nm1luQN5mG4j1mGtoVIEX/y9A4FAge0dY0l1HM7NAzRWZF1WfUvXWs0gTCKWY7+xp6I2XseL+9fwvmGrxmHg/5QcjHRoaq8p5eELN3QH7bPkiqFZxFcHUdkdkKKGLhGWuGwvR0ziMBea8qH5L3DXqfkandM3CKiXYyArCW37k2Nq7vjD root@c3po
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClDG9BO/cUpgBEUdLHzcgT6ImUGefB1sLaA5SHwhIBA6EVs2wPsx3LzvfXFNmDObooYefeTCBFcDINUxSEWm8eg4agk2outM80uXfHDXi9J1tV51lekiKe1vUpIt5iCT2/c3w3vJswZPChB7qX3ZDGkqvuOBMAluYTnLWgxn+/sU35SQSla2t1S9WgfgTXKf/XlJUVbhptaVy7ZgwhSNihrCRKUe8jQx/w+F9WAp721CozApq2ekRODSmeU8YLJrBdrrXGnyK860BLa5kXBb8OvKQG3G/NnMe9ciRjMvUQKvvbSQIteaV8q30Ci/KClWdRaqJN2s1K/FOOtVFs9SWR root@c3po' > /home/ansible/.ssh/authorized_keys
chmod 0600 /home/ansible/.ssh/authorized_keys
chown -R ansible /home/ansible
