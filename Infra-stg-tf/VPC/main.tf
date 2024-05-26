provider "aws" {
  region = var.region
}

resource "aws_vpc" "dcshp_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.default_name
  }
}

resource "aws_subnet" "dcshp_subnet" {
  count = length(var.subnet_cidrs)
  vpc_id = aws_vpc.dcshp_vpc.id
  cidr_block = element(var.subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "dcshp-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "dcshp_igw" {
  vpc_id = aws_vpc.dcshp_vpc.id
  tags = {
    Name = "dcshp-igw"
  }
}

resource "aws_route_table" "dcshp_route_table" {
  vpc_id = aws_vpc.dcshp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dcshp_igw.id
  }
  tags = {
    Name = "dcshp-route-table"
  }
}

resource "aws_route_table_association" "dcshp_route_table_association" {
  count = length(var.subnet_cidrs)
  subnet_id = element(aws_subnet.dcshp_subnet[*].id, count.index)
  route_table_id = aws_route_table.dcshp_route_table.id
}