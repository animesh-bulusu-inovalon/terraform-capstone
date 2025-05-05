// Defines security groups for the ALB and EC2 instances with ingress and egress rules.
// ALB SG allows inbound HTTP from anywhere.
// Instance SG allows inbound HTTP from ALB SG and SSH from anywhere.

resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] // Allow all outbound traffic
  }

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "instance-security-group"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id] // Allow HTTP from ALB only
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow SSH from anywhere (consider restricting)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] // Allow all outbound traffic
  }

  tags = {
    Name = "instance-sg"
  }
}