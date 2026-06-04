resource "aws_instance" "app_server" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t3.micro"
  key_name      = "Key_Of_Ec2_Project"
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  user_data = <<-EOF

              #!/bin/bash

              sudo apt update

              sudo apt install -y docker.io

              sudo systemctl start docker

              sudo systemctl enable docker

              sudo usermod -aG docker ubuntu

              EOF

  tags = {
    Name = "app-translator-backend"
  }
}