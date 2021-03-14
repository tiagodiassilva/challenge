### Cria inventario dinamico
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  docker-dns = aws_instance.docker.public_dns,
  docker-ip = aws_instance.docker.public_ip,
  docker-eip = aws_instance.docker.private_ip,
  docker-id = aws_instance.docker.id
 }
 )
 filename = "inventory"
}
