resource "aws_ebs_volume" "jenkins_data" {
  availability_zone = var.availability_zone
  size              = 20
  tags = {
    Name = "jenkins-data"
  }
}

resource "aws_volume_attachment" "jenkins_data_attachment" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.jenkins_data.id
  instance_id = var.instance_id
}

