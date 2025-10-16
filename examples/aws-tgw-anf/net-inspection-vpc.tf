resource "aws_vpc" "inspection_vpc" {
  provider   = aws.target
  cidr_block = "10.255.255.0/24"
  tags       = merge(var.tags, { Name = "${var.network_name}-inspection" })
}

resource "aws_subnet" "uplink1" {
  provider          = aws.target
  vpc_id            = aws_vpc.inspection_vpc.id
  cidr_block        = "10.255.255.0/26"
  availability_zone = "eu-west-1a"
  tags              = merge(var.tags, { Name = "${var.network_name}-uplink1" })
}

resource "aws_subnet" "firewall1" {
  provider          = aws.target
  vpc_id            = aws_vpc.inspection_vpc.id
  cidr_block        = "10.255.255.64/26"
  availability_zone = "eu-west-1a"
  tags              = merge(var.tags, { Name = "${var.network_name}-firewall1" })
}

resource "aws_subnet" "uplink2" {
  provider          = aws.target
  vpc_id            = aws_vpc.inspection_vpc.id
  cidr_block        = "10.255.255.128/26"
  availability_zone = "eu-west-1b"
  tags              = merge(var.tags, { Name = "${var.network_name}-uplink2" })
}

resource "aws_subnet" "firewall2" {
  provider          = aws.target
  vpc_id            = aws_vpc.inspection_vpc.id
  cidr_block        = "10.255.255.192/26"
  availability_zone = "eu-west-1b"
  tags              = merge(var.tags, { Name = "${var.network_name}-firewall2" })
}

resource "aws_route_table" "uplink_default" {
  provider = aws.target
  vpc_id   = aws_vpc.inspection_vpc.id
  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = aws_ec2_transit_gateway_vpc_attachment.inspection.transit_gateway_id
  }
  tags = merge(var.tags, { Name = "${var.network_name}-uplink" })
}
