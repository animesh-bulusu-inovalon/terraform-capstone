output "blue_launch_template_id" {
  description = "ID of the blue launch template"
  value       = aws_launch_template.blue.id
}

output "green_launch_template_id" {
  description = "ID of the green launch template"
  value       = aws_launch_template.green.id
}

output "blue_launch_template_arn" {
  description = "ARN of the blue launch template"
  value       = aws_launch_template.blue.arn
}

output "green_launch_template_arn" {
  description = "ARN of the green launch template"
  value       = aws_launch_template.green.arn
}

output "blue_launch_template_latest_version" {
  description = "Latest version of the blue launch template"
  value       = aws_launch_template.blue.latest_version
}

output "green_launch_template_latest_version" {
  description = "Latest version of the green launch template"
  value       = aws_launch_template.green.latest_version
}