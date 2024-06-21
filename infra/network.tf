resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}



resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet-gw"
  }
}



resource "aws_subnet" "public" {
  for_each   = var.public_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value

  availability_zone = "us-east-${split("-", each.key)[1]}"

  tags = {
    Name = each.key
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}



resource "aws_subnet" "private_app" {
  for_each   = var.private_app_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value

  availability_zone = "us-east-${split("-", each.key)[1]}"

  tags = {
    Name = each.key
  }
}
resource "aws_route_table" "private_app" {
  for_each = aws_subnet.private_app
  vpc_id   = aws_vpc.vpc.id

  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_instance.natgw["public-${split("-", each.key)[1]}"].primary_network_interface_id
  }

  tags = {
    Name = each.key
  }
}
resource "aws_route_table_association" "private_app" {
  for_each       = aws_subnet.private_app
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_app[each.key].id
}



resource "aws_subnet" "private_db" {
  for_each   = var.private_db_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value

  availability_zone = "us-east-${split("-", each.key)[1]}"

  tags = {
    Name = each.key
  }
}

