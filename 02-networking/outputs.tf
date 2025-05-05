output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "instance_sg_id" {
  value = aws_security_group.instance_sg.id
}
