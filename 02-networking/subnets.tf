// Creates public and private subnets within the VPC, each in specified AZs.
// The public subnet maps public IPs on launch to allow internet access.

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.availability_zone_public
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.availability_zone_private

  tags = {
    Name = "private-subnet"
  }
}
