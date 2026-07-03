terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.53.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"

}

resource "aws_vpc" "Soar_VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "soar_vpc"
  }
}

resource "aws_internet_gateway" "soar_gateway" {
  vpc_id = aws_vpc.Soar_VPC.id
  tags = {
    Name = "soar_gateway"
  }
}

resource "aws_subnet" "sub_public" {
  vpc_id = aws_vpc.Soar_VPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    name = "soar_public"
  }

}

// Private subnet 1a
resource "aws_subnet" "sub_private_1" {
  vpc_id = aws_vpc.Soar_VPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    name = "soar_private_1a"
  }

}

//Private subnet 1b
resource "aws_subnet" "sub_private_2" {
  vpc_id = aws_vpc.Soar_VPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    name = "soar_private_1b"
  }

}
//Public subnet 1a
resource "aws_subnet" "sub_public_1" {
  vpc_id = aws_vpc.Soar_VPC.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
  tags = {
    name = "soar_public_1a"
  }

}

//Public subnet 1b
resource "aws_subnet" "sub_public_2" {
  vpc_id = aws_vpc.Soar_VPC.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"
  tags = {
    name = "soar_public_1b"
  }

}