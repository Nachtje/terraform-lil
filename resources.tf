resource "aws_vpc" "nna_environment-example-two" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "nna_terraform-aws-vpc-example-two"
  }
}

resource "aws_subnet" "nna_subnet1" {
  cidr_block = "${cidrsubnet(aws_vpc.nna_environment-example-two.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.nna_environment-example-two.id}"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "nna_subnet2" {
  cidr_block = "${cidrsubnet(aws_vpc.nna_environment-example-two.cidr_block, 2, 2)}"
  vpc_id = "${aws_vpc.nna_environment-example-two.id}"
  availability_zone = "us-west-2b"
}
resource "aws_security_group" "nna_subnetsecurity" {
  vpc_id = "${aws_vpc.nna_environment-example-two.id}"

  ingress {
    cidr_blocks = [
      "${aws_vpc.nna_environment-example-two.cidr_block}"
    ]

    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
}