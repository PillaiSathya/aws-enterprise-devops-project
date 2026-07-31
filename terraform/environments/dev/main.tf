resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "aws-enterprise-dev-vpc"
    Environment = "dev"
    Project     = "aws-enterprise-devops"
  }
}
