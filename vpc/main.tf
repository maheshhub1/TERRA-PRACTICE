resource "aws_vpc" "VPC" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "CUSTOM-VPC"
  }
}

resource "aws_subnet" "pub" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.sub-cidr
  tags = {
    Name = "pub-sub"
  }
}

resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "pub-route"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "IGW-1"
  }
}

resource "aws_route_table_association" "igw-sub-associaton" {
  subnet_id      = aws_subnet.pub.id
  route_table_id = aws_route_table.pub-route.id
}

resource "aws_security_group" "security" {
  name   = "tera-security"
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "Tera-security"
  }

  ingress {
    description = "for ssh access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "ec2" {
  ami                    = "ami-02b49a24cfb95941c"
  instance_type          = "t2.micro"
  key_name               = "Tera"
  subnet_id              = aws_subnet.pub.id
  vpc_security_group_ids = [aws_security_group.security.id]
  tags = {
    Name = "ec2with-in-vpc"
  }
}


