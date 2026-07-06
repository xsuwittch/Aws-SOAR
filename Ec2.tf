//Private Victim
resource "aws_instance" "victim" {
  ami           = "ami-01a00762f46d584a1"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.sub_private_1.id
  vpc_security_group_ids = [ aws_security_group.victim_sg.id ]
  tags = {
    Name = "victim"
  }
  
}

// Public Attacker
resource "aws_instance" "Attacker" {
  ami           = "ami-01a00762f46d584a1"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.sub_public_1.id
  vpc_security_group_ids = [ aws_security_group.attacker_sg.id ]
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

//Quarnatine SG
resource "aws_security_group" "quarantine_sg" {
  name = "quarantine_sg"
  description = "Security group for quarantined instances"
  vpc_id = aws_vpc.Soar_VPC.id

  // No inbound or outbound rules, as this SG is used to isolate instances
  tags = {
    name = "quarantine SG"
  }
}