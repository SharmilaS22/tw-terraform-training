resource "aws_vpc" "sh_vpc_main" {
  cidr_block = var.vpc_cidr # 256 IPs 
}

resource "aws_subnet" "sh_public_subnet_1" {
  vpc_id                  = aws_vpc.sh_vpc_main.id
  cidr_block              = var.public_subnet_cidr #128 IPs
  map_public_ip_on_launch = true                   # public subnet
  availability_zone       = var.public_subnet_az
}

resource "aws_internet_gateway" "sh_internet_gw" {
  vpc_id = aws_vpc.sh_vpc_main.id
}

resource "aws_route_table" "sh_routetable_for_publicsubnt" {
  vpc_id = aws_vpc.sh_vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sh_internet_gw.id
  }
}

resource "aws_route_table_association" "sh_rta" {
  subnet_id      = aws_subnet.sh_public_subnet_1.id
  route_table_id = aws_route_table.sh_routetable_for_publicsubnt.id
}