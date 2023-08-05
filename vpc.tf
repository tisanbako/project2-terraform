resource "aws_vpc" "myvpc" {
  cidr_block  = var.vpc_cidr
  tags = {
    Name = "${terraform.workspace}-vpc"
  }
}

resource "aws_subnet" "public1" {
  count = length(var.public1_sub_cidr)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public1_sub_cidr[count.index]
  availability_zone = var.az[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${terraform.workspace}-pub1sub-${count.index}"
  }
}

resource "aws_subnet" "public2" {
  count = length(var.public2_sub_cidr)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public2_sub_cidr[count.index]
  availability_zone = var.az[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${terraform.workspace}-pub2sub-${count.index}"
  }
}

resource "aws_subnet" "private1" {
  count = length(var.private1_sub_cidr)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private1_sub_cidr[count.index]
  availability_zone = var.az[count.index]

  tags = {
    Name = "${terraform.workspace}-private1sub-${count.index}"
  }
}

resource "aws_subnet" "private2" {
  count = length(var.private2_sub_cidr)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private2_sub_cidr[count.index]
  availability_zone = var.az[count.index]

  tags = {
    Name = "${terraform.workspace}-private2sub-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "${terraform.workspace}-IGW"
  }
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${terraform.workspace}-pubRT"
  }
}

resource "aws_route_table_association" "pubrtasso" {
  count = length(aws_subnet.public1)  
  subnet_id      = aws_subnet.public1[count.index].id
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_route_table_association" "pubrtasso2" {
  count = length(aws_subnet.public2)  
  subnet_id      = aws_subnet.public2[count.index].id
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_eip" "myeip" {
  count = 2
  
}

resource "aws_nat_gateway" "mynat" {
  count = 2 
  allocation_id = aws_eip.myeip[count.index].id
  subnet_id     = aws_subnet.public1[count.index].id

  tags = {
    Name = "${terraform.workspace}-natgw-${count.index}"
  }
}  

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.myvpc.id
  count = 2

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynat[count.index].id
  }

  tags = {
    Name = "${terraform.workspace}-prvtRT-${count.index}"
  }
}

resource "aws_route_table_association" "prvtasso1" {
  count = length(aws_subnet.private1)  
  subnet_id      = aws_subnet.private1[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "prvtasso2" {
  count = length(aws_subnet.private2)  
  subnet_id      = aws_subnet.private2[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
