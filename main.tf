provider "aws" {
  region  = "eu-west-1" # Don't change the region
}

# Add your S3 backend configuration here

terraform {
  backend "s3" {
    bucket = "3.devops.candidate.exam"
    region = "eu-west-1"
    key = "Pritam.Chaudhari/terraform.tfstate"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "VPC"
  }
}
resource "aws_subnet" "public" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  nat_gateway = data.aws_nat_gateway.nat.id
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  nat_gateway = data.aws_nat_gateway.nat.id
  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_route_table" "example" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "10.0.1.0/24"
  }

  tags = {
    Name = "Public-RT"
  }
}
resource "aws_route_table" "example" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "10.0.2.0/24"
    nat_gateway = data.aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private-RT"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}



resource "aws_iam_role" "iam_for_lambda" {
  aws_iam_role = data.aws_iam_role.lambda.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.js"
  output_path = "lambda_function_payload.zip"
}

payload = {
  "subnet_id": "",
  "name": "Pritam",
  "email": "<pritam.chaudhari2105@gmail.com>"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.test"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"

 
}



