resource "aws_networkfirewall_firewall" "inspection" {
  provider            = aws.target
  count               = local.anf_policy_arn == null ? 0 : 1
  name                = var.network_name
  firewall_policy_arn = local.anf_policy_arn
  transit_gateway_id  = aws_ec2_transit_gateway.core_tgw.id
  tags                = var.tags

  availability_zone_mapping {
    availability_zone_id = data.aws_availability_zones.target.zone_ids[0]
  }

  availability_zone_mapping {
    availability_zone_id = data.aws_availability_zones.target.zone_ids[1]
  }
}
