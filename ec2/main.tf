resource "aws_instance" "EC2" {
  ami = var.ami-id
  instance_type = var.type-instance
  key_name = var.key-name
  tags = {
    Name = "TERA-INSTA"
  }
}