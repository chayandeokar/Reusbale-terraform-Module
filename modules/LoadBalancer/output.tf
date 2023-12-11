output "load_balancer_target_group_arn" {
  value = aws_lb_target_group.telb.arn
}
output "subnet_id"{
  value = aws_subnet.subnet_a.id
}

