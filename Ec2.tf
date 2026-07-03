//Private Victim
resource "aws_instance" "victim" {
  ami           = "ami-0aba19e56f3eaec05"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.sub_private_1.id
  security_groups = [ aws_security_group.victim_sg ]
  tags = {
    Name = "victim"
  }
  
}

// Public Attacker
resource "aws_instance" "Attacker" {
  ami           = "ami-0aba19e56f3eaec05"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.sub_public_1.id
  security_groups = [ aws_security_group.attacker_sg ]
  tags = {
    Name = "attacker"
  }
  
}

// Security Groups
resource "aws_security_group" "attacker_sg" {
  name = "attacker_sg"
  description = "Only allow ssh into attacker"
  vpc_id =  aws_vpc.Soar_VPC.id

  // ibound rule
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // bascially allow any one to ssh 
  }

    //outbound
    egress {
        from_port = 0
        to_port = 0
        description = "Allow all outbound traffic"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      name = "attacker SG"
    }
}

// Security Groups
resource "aws_security_group" "victim_sg" {
  name = "victim_sg"
  description = "Only allow ssh into victim"
  vpc_id =  aws_vpc.Soar_VPC.id

  // ibound rule
    // no inbound rule as its an isolated instance

    //outbound
    egress {
        from_port = 0
        to_port = 0
        description = "Allow all outbound traffic"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      name = "victim SG"
    }
}