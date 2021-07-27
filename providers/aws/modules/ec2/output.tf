
output "ec2_ssh_key" {
  value = aws_key_pair.jb_key.key_name
}