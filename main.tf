provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

# creating instance resource
resource "aws_instance" "ec2_instance" {
    ami = "${var.ami_id}"
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ami_key_pair_name}"

    tags = {
      Name = "Terraform ec2"
    }

#installing nginx app with terraform
user_data = <<-EOF
            #!/bin/bash
            sudo apt update -y
            sudo apt install nginx -y
            sudo systemctl start nginx
            sudo systemctl enable nginx
            sudo yum install npm -y
            EOF
} 

#how to provission RDS database
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}