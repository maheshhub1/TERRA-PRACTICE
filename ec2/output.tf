output "insta-pub-ip" {
  description = "to print public ip address of instance"
  value = aws_instance.EC2.public_ip
  sensitive = true
}