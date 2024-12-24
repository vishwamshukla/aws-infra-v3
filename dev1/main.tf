provider "aws"{
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  }

# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "dev" {
  cidr_block           = var.cidr_block_vpc
  # instance_tenancy     = "default"
  # enable_dns_support   = "true"
  # enable_dns_hostnames = "true"
  # enable_classiclink   = "false"
  tags = {
    Name = var.vpc_name_tag
  }
}

# Creating Public Subnets in VPC
resource "aws_subnet" "dev-public-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.cidr_block_public_1
  # map_public_ip_on_launch = "true"
  availability_zone       = var.az_public_1

  tags = {
    Name = var.public_1_name_tag
  }
}

resource "aws_subnet" "dev-public-2" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.cidr_block_public_2
  # map_public_ip_on_launch = "true"
  availability_zone       = var.az_public_2

  tags = {
    Name = var.public_2_name_tag
  }
}
resource "aws_subnet" "dev-public-3" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.cidr_block_public_3
  # map_public_ip_on_launch = "true"
  availability_zone       = var.az_public_3

  tags = {
    Name = var.public_3_name_tag
  }
}

# Creating Private Subnets in VPC
resource "aws_subnet" "dev-private-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.cidr_block_private_1
  # map_public_ip_on_launch = "true"
  availability_zone       = var.az_private_1

  tags = {
    Name = var.private_1_name_tag
  }
}

resource "aws_subnet" "dev-private-2" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.cidr_block_private_2
  # map_public_ip_on_launch = "true"
  availability_zone       = var.az_private_2

  tags = {
    Name = var.private_2_name_tag
  }
}
resource "aws_subnet" "dev-private-3" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = var.cidr_block_private_3
  # map_public_ip_on_launch = "true"
  availability_zone       = var.az_private_3

  tags = {
    Name = var.private_3_name_tag
  }
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = var.internet_gateway_name_tag
  }
}

# Creating Public Route Tables for Internet gateway
resource "aws_route_table" "dev-public" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = var.cidr_block_public_route_table
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  tags = {
    Name = var.public_route_table_name_tag
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "dev-public-1-a" {
  subnet_id      = aws_subnet.dev-public-1.id
  route_table_id = aws_route_table.dev-public.id
}

resource "aws_route_table_association" "dev-public-2-a" {
  subnet_id      = aws_subnet.dev-public-2.id
  route_table_id = aws_route_table.dev-public.id
}

resource "aws_route_table_association" "dev-public-3-a" {
  subnet_id      = aws_subnet.dev-public-3.id
  route_table_id = aws_route_table.dev-public.id
}

# Creating Private Route Tables for Internet gateway
resource "aws_route_table" "dev-private" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = var.cidr_block_private_route_table
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  tags = {
    Name = var.private_route_table_name_tag
  }
}

# Creating Route Associations Private subnets
resource "aws_route_table_association" "dev-private-1-a" {
  subnet_id      = aws_subnet.dev-private-1.id
  route_table_id = aws_route_table.dev-private.id
}

resource "aws_route_table_association" "dev-private-2-a" {
  subnet_id      = aws_subnet.dev-private-2.id
  route_table_id = aws_route_table.dev-private.id
}

resource "aws_route_table_association" "dev-private-3-a" {
  subnet_id      = aws_subnet.dev-private-3.id
  route_table_id = aws_route_table.dev-private.id
}