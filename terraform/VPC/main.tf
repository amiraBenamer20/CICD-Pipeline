/*module "eks" {
  source = "../EKS"
  sg_ids = module.sg-eks.security_group_public
  vpc_id = aws_vpc.dpp-vpc.id
  subnet_ids = [aws_subnet.dpp-public-subnet-1.id,aws_subnet.dpp-public-subnet-2.id]
}

module "sg-eks" {
  source = "../SG-EKS"
  vpc_id = aws_vpc.dpp-vpc.id
}*/

provider "aws" {
  region = "eu-west-3"
}



resource "aws_instance" "machine" {
  ami = "ami-01d21b7be69801c2f" //ubuntu 22-04 LTS
  instance_type = "t2.micro"
  key_name = "dpp"
  vpc_security_group_ids = [aws_security_group.devops2_sg.id]
  subnet_id = aws_subnet.dpp-public-subnet-1.id

  for_each = toset(["Ansible","Jenkins-master","Jenkins-slave"])
  tags = {
    Name = "${each.key}"
  }
}

