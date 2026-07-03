//Private Victim
resource "aws_instance" "victim" {
  ami           = "ami-0aba19e56f3eaec05"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.sub_private_1.id
  tags = {
    Name = "victim"
  }
  
}

// Public Attacker
resource "aws_instance" "Attacker" {
  ami           = "ami-0aba19e56f3eaec05"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.sub_public_1.id
  tags = {
    Name = "attacker"
  }
  
}