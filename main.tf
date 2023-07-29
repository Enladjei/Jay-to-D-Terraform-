# Netwoking for Grace IT Group

resource "aws_vpc" "Grace-IT-Group-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Grace-IT-Group-VPC"
  }
}


# Public Subnet 1

resource "aws_subnet" "Prod-Public-subnet-1" {
  vpc_id     = aws_vpc.Grace-IT-Group-VPC.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Prod-Public-subnet-1"
  }
}

# Public Subnet 2

resource "aws_subnet" "Prod-Public-subnet-2" {
  vpc_id     = aws_vpc.Grace-IT-Group-VPC.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "Prod-Public-subnet-2"
  }
}

# Private Subnet 1

resource "aws_subnet" "Prod-Private-subnet-1" {
  vpc_id     = aws_vpc.Grace-IT-Group-VPC.id
  cidr_block = "10.0.12.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Prod-Private-subnet-1"
  }
}

# Private Subnet 2

resource "aws_subnet" "Prod-Private-subnet-2" {
  vpc_id     = aws_vpc.Grace-IT-Group-VPC.id
  cidr_block = "10.0.13.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "Prod-Private-subnet-2"
  }
}


# Public Route table

resource "aws_route_table" "Prod-Public-Route-Table" {
  vpc_id = aws_vpc.Grace-IT-Group-VPC.id

  tags = {
    Name = "Prod-Public-Route-Table"
  }
}

# Associate Public subnets to public Route Table

resource "aws_route_table_association" "Prod-RT-association-to-Public-Subnet-1" {
  subnet_id      = aws_subnet.Prod-Public-subnet-1.id
  route_table_id = aws_route_table.Prod-Public-Route-Table.id
}

resource "aws_route_table_association" "Prod-RT-association-to-Public-Subnet-2" {
  subnet_id      = aws_subnet.Prod-Public-subnet-2.id
  route_table_id = aws_route_table.Prod-Public-Route-Table.id
}


# Private Route table

resource "aws_route_table" "Prod-Private-Route-Table" {
  vpc_id = aws_vpc.Grace-IT-Group-VPC.id

  tags = {
    Name = "Prod-Private-Route-Table"
  }
}

# Associate Private subnets to private Route Table

resource "aws_route_table_association" "Prod-RT-association-to-Private-Subnet-1" {
  subnet_id      = aws_subnet.Prod-Private-subnet-1.id
  route_table_id = aws_route_table.Prod-Private-Route-Table.id
}

resource "aws_route_table_association" "Prod-RT-association-to-Private-Subnet-2" {
  subnet_id      = aws_subnet.Prod-Private-subnet-2.id
  route_table_id = aws_route_table.Prod-Private-Route-Table.id
}


# Internet Gateway

resource "aws_internet_gateway" "Prod-IGW" {
  vpc_id = aws_vpc.Grace-IT-Group-VPC.id

  tags = {
    Name = "Prod-IGW"
  }
}

# Associate Internet Gateway to Public Route table

resource "aws_route_table_association" "Prod-IGW-Association" {
  gateway_id     = aws_internet_gateway.Prod-IGW.id
  route_table_id = aws_route_table.Prod-Public-Route-Table.id
}


# Create Elastic IP Address

resource "aws_eip" "Grace-IT-Group-eip" {
  tags = {
    Name = "Grace-IT-Group-eip"
  }
}

# Create NAT Gateway

resource "aws_nat_gateway" "Prod-Nat-Gateway" {
  allocation_id = aws_eip.Grace-IT-Group-eip.id
  subnet_id     = aws_subnet.Prod-Public-subnet-1.id

  tags = {
    Name = "Prod-Nat-Gateway"
  }
}

# NAT Associate with Private route 

resource "aws_route" "Prod-Nat-Association" {
  route_table_id = aws_route_table.Prod-Private-Route-Table.id
  gateway_id = aws_nat_gateway.Prod-Nat-Gateway.id
  destination_cidr_block = "0.0.0.0/0"
}



