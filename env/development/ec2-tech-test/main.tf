module "ec2_instance"{
  source     = "G:/Reusbale-terraform-Module-master/modules/VirtualMachine"
  ami = "ami-02a2af70a66af6dfb"
  instance_type = "t2.micro"
  subnet_id   = module.load_balancer.subnet_id
}

module "load_balancer" {
  source   = "G:/Reusbale-terraform-Module-master/modules/LoadBalancer"
}


resource "aws_lb_target_group_attachment" "ec2_attachment" {
  target_group_arn = module.load_balancer.load_balancer_target_group_arn
  target_id        = module.ec2_instance.ec2_instance_id
}

