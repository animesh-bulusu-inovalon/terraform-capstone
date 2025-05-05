resource "aws_launch_template" "blue" {
  name_prefix   = "blue-"
  image_id      = "ami-02d0b04e8c50472ce"
  instance_type = "t3.micro"

  vpc_security_group_ids = [data.terraform_remote_state.networking_layer.outputs.instance_sg_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Blue Environment</h1>" > /var/www/html/index.html
    EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "blue-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "green" {
  name_prefix   = "green-"
  image_id      = "ami-02d0b04e8c50472ce"
  instance_type = "t3.micro"

  vpc_security_group_ids = [data.terraform_remote_state.networking_layer.outputs.instance_sg_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Green Environment</h1>" > /var/www/html/index.html
    EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "green-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "blue" {
  name                = "blue-asg"
  vpc_zone_identifier = [data.terraform_remote_state.networking_layer.outputs.public_subnet_id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  target_group_arns = [data.terraform_remote_state.alb_layer.outputs.blue_target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "blue-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "green" {
  name                = "green-asg"
  vpc_zone_identifier = [data.terraform_remote_state.networking_layer.outputs.public_subnet_id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  target_group_arns = [data.terraform_remote_state.alb_layer.outputs.green_target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "green-instance"
    propagate_at_launch = true
  }
}
