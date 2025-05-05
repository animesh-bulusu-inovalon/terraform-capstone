// Defines EC2 launch templates for blue and green instances used in a blue-green Zero Downtime Deployment.

resource "aws_launch_template" "blue" {
  name_prefix   = "blue-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [data.terraform_remote_state.networking_layer.outputs.instance_sg_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "<h1>Blue Environment</h1>" | sudo tee /var/www/html/index.html
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
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [data.terraform_remote_state.networking_layer.outputs.instance_sg_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "<h1>Green Environment</h1>" | sudo tee /var/www/html/index.html
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

// Creates Auto Scaling Groups (ASGs) for blue and green launch templates to maintain desired capacity
// Each ASG is attached to respective target groups for load balancing.

resource "aws_autoscaling_group" "blue" {
  name                = "blue-asg"
  vpc_zone_identifier = [data.terraform_remote_state.networking_layer.outputs.public_subnet_id]
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  target_group_arns = [data.terraform_remote_state.alb_layer.outputs.blue_target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 600

  tag {
    key                 = "Name"
    value               = "blue-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "green" {
  name                = "green-asg"
  vpc_zone_identifier = [data.terraform_remote_state.networking_layer.outputs.public_subnet_id]
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  target_group_arns = [data.terraform_remote_state.alb_layer.outputs.green_target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 600

  tag {
    key                 = "Name"
    value               = "green-instance"
    propagate_at_launch = true
  }
}
