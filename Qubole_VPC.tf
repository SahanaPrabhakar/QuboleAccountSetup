resource "aws_vpc" "qubole_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "terraform-qubole-vpc"
    }
}

resource "aws_internet_gateway" "qubole_igw" {
    vpc_id = "${aws_vpc.qubole_vpc.id}"
    tags {
        Name = "terraform-qubole-igw"
    }
}

/*
  Public Subnet
*/
resource "aws_subnet" "subnet-public" {
    vpc_id = "${aws_vpc.qubole_vpc.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "${var.availability_zone}"

    tags {
        Name = "Qubole public subnet"
    }
}

resource "aws_route_table" "subnet-route-table-public" {
    vpc_id = "${aws_vpc.qubole_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.qubole_igw.id}"
    }

    tags {
        Name = "Qubole public subnet RT"
    }
}

resource "aws_route_table_association" "subnet-public" {
    subnet_id = "${aws_subnet.subnet-public.id}"
    route_table_id = "${aws_route_table.subnet-route-table-public.id}"
}

/*
  NAT Gateway
*/
resource "aws_eip" "forNat" {
    vpc      = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.forNat.id}"
  subnet_id     = "${aws_subnet.subnet-public.id}"

  tags {
        Name = "Qubole NAT GW"
    }
}

/*
  Private Subnet
*/
resource "aws_subnet" "subnet-private" {
    vpc_id = "${aws_vpc.qubole_vpc.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "${var.availability_zone}"

    tags {
        Name = "Qubole private subnet"
    }
}

resource "aws_route_table" "subnet-route-table-private" {
    vpc_id = "${aws_vpc.qubole_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags {
        Name = "Qubole private subnet RT"
    }
}

resource "aws_route_table_association" "subnet-private" {
    subnet_id = "${aws_subnet.subnet-private.id}"
    route_table_id = "${aws_route_table.subnet-route-table-private.id}"
}

