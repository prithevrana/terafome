provider "aws" {
	region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "myvpc"
  }
}

resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "my_gateway"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.cidr_block
  availability_zone = "${var.region}a" 

  tags = {
    Name = "my_subnet"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "my_route_table"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.my_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_gateway.id
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.myvpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my_sg"
  }
}

resource "aws_instance" "barkha-sharma" {
  ami           = "ami-01f27fa7b8397d77d"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0c9b01f19d9e04c4b"
  key_name      = "test-key"
 # lifecycle {
	#prevent_destroy = true
 # }
  tags = {
	name = "tannu"
  }
}
