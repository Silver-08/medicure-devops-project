provider "aws" {
  region = "us-east-1" # change as needed
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "k8s_sg" {
  name        = "k8s-security-group"
  description = "Allow all inbound traffic for Kubernetes cluster"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "k8s_master" {
  ami                    = "ami-0c02fb55956c7d316" # Ubuntu 22.04 LTS (update if needed)
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.jenkins_key.key_name
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  tags = {
    Name = "K8S-Master"
  }
}

resource "aws_instance" "k8s_worker" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.jenkins_key.key_name
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  tags = {
    Name = "K8S-Worker"
  }
}

resource "aws_instance" "monitoring" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.jenkins_key.key_name
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  tags = {
    Name = "Monitoring"
  }
}

output "k8s_master_ip" {
  value = aws_instance.k8s_master.public_ip
}

output "k8s_worker_ip" {
  value = aws_instance.k8s_worker.public_ip
}

output "monitoring_ip" {
  value = aws_instance.monitoring.public_ip
}
