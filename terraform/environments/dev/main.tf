resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "aws-enterprise-dev-vpc"
    Environment = "dev"
    Project     = "aws-enterprise-devops"
  }
}

resource "aws_subnet" "public_subnet_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "ap-south-1a"

  map_public_ip_on_launch = true

  tags = {
    Name        = "public-subnet-1"
    Environment = "dev"
    Project     = "aws-enterprise-devops"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-subnet-2"
    Environment = "dev"
    Project     = "aws-enterprise-devops"
  }
}
