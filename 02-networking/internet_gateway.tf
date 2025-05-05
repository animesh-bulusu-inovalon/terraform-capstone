// Creates an Internet Gateway to enable internet connectivity for public subnets.

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main-igw"
  }
}