resource "aws_ec2_transit_gateway" "core_tgw" {
  provider                        = aws.target
  description                     = "core network transit gateway"
  default_route_table_association = "enable"

  tags = merge(var.tags, { Name = var.network_name })
}

resource "aws_ec2_transit_gateway_route_table" "inspection" {
  provider           = aws.target
  transit_gateway_id = aws_ec2_transit_gateway.core_tgw.id
  tags               = merge(var.tags, { Name = "${var.network_name}-inspection" })
}

resource "aws_ec2_transit_gateway_vpc_attachment" "inspection" {
  provider               = aws.target
  subnet_ids             = [aws_subnet.uplink1.id, aws_subnet.uplink2.id]
  transit_gateway_id     = aws_ec2_transit_gateway.core_tgw.id
  vpc_id                 = aws_vpc.inspection_vpc.id
  appliance_mode_support = "enable"
  tags                   = merge(var.tags, { Name = "${var.network_name}-inspection" })
}

resource "aws_ec2_transit_gateway_route_table_association" "inspection" {
  provider                       = aws.target
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection.id
}

resource "aws_ec2_transit_gateway_route" "aggregation" {
  provider                       = aws.target
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.core_tgw.association_default_route_table_id
}

# Any user attachment would connect to the default TGW route table
# Every attachment would then propagate to the inspectin TGW route table
