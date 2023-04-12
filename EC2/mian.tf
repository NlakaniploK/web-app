provider "aws" {
    region = "us-west-1"
}

resource "aws_instance" "dotnet-web"{
    ami = "ami-0fa1de1d60de6a97e"
    key_name = "ubunt-keypair"
    instance_type = "t2.micro"
    user_data = file("script.sh")
    vpc_security_group_ids = [aws_security_group.allow_tls.id]

    tags = {
      "Name" = "terraform-instance"
    }
}
resource "aws_security_group" "allow_tls" {
 
  ingress {
    description      = "Allow https to instance"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups = []
  }
  ingress {
    description      = "Allow ssh to the instance"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups = []
  }
  ingress {
    description      = "Allow http instance"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups = []
  }
  ingress {
    description      = "To allow access to the docker container port"
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids   = []
    security_groups = []
  }

  egress {
    description      = "Allow all outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids   = []
    security_groups = []
  }
  tags = {
    Name = "Secrete_Groups"
  }
}