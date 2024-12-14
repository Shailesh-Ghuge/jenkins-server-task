resource "aws_instance" "jenkins" {
  ami           = "ami-0327f51db613d7bd2" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  tags = {
    Name = "jenkins-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y git docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose

              # Create the directory and clone the repository
              mkdir -p /home/ec2-user/jenkins
              cd /home/ec2-user/jenkins
              git clone https://github.com/Shailesh-Ghuge/task.git .

              # Run Docker Compose
              sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
              sudo docker-compose up -d
              EOF
}

output "instance_id" {
  value = aws_instance.jenkins.id
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}

