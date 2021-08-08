provider "aws" {
	access_key = "AKIAWVWBTZ57ZTTNHAFM"
	secret_key = "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"
	region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
	ami = "ami-05f7491af5eef733a"
	instance_type = "t3.micro"
	vpc_security_group_ids = [aws_security_group.my_webserver.id]
	user_data = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt -y install apache2
sudo myip=`curl http://192.168.0.200/latest/meta-data/local-ipv4`
sudo chmod 777 /var/www/html/index.html	
sudo echo "<h2>WebServer with IP: $myip</h2?>" > /var/www/html/index.html
sudo systemctl restart apache2
chkconfig apache2 on
EOF
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My Security Group"
#  vpc_id      = aws_vpc.main.id

  ingress {
  #  description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
 #   ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  
  ingress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
}

  ingress {
	from_port = 443
	to_port = 443
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  #  ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "My Security Group"
  }
}

