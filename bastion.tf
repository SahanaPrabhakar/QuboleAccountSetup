resource "aws_security_group" "bastion_sg" {
  name = "bastion"
  description = "Allow SSH traffic"
  vpc_id = "${aws_vpc.qubole_vpc.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 7000
    to_port = 7000
    protocol = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami = "${var.bastion_ami}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet-public.id}"
  security_groups = ["${aws_security_group.bastion_sg.id}"] 
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc = true
}
