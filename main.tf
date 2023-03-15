provider "aws" {
  region  = "eu-west-1" # Don't change the region
}

# Add your S3 backend configuration here


terraform {
  backend "s3" {
    bucket = "3.devops.candidate.exam"
    region = "eu-west-1"
    key = Pritam Chaudhari
  }
}

resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "VPC"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  nat_gateway = data.aws_nat_gateway.nat.id
  tags = {
    Name = "Subnet"
  }
}

resource "aws_route_table" "example" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "Private-RT"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}





data "aws_nat_gateway" "nat" {
  id = "nat-07863fc48f5b99110"
}

data "aws_vpc" "vpc" {
  id = "vpc-0de2bfe0f5fc540e0"
}

data "aws_iam_role" "lambda" {
  name = "DevOps-Candidate-Lambda-Role"
}

