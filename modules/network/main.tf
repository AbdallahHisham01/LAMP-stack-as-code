resource "aws_vpc" "project_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "project_vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.project_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.project_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.project_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private_subnet_2"
  }
}

resource "aws_internet_gateway" "main_IGW" {
  vpc_id = aws_vpc.project_vpc.id
  tags = {
    Name = "main_IGW"
  }
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_IGW.id
  }

  route {
     cidr_block = "10.0.0.0/16"
     gateway_id = "local"
  }

  tags = {
    Name = "public_subnet_route_table"
  }
}

resource "aws_route_table_association" "pub_subnet_to_route_table" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "NATGW" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT GW"
  }
}

resource "aws_route_table" "Private_RT" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NATGW.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "Private routing table"
  }
}

resource "aws_route_table_association" "Private2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.Private_RT.id
}