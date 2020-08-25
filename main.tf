#Transit VPC
resource "aviatrix_vpc" "default" {
  cloud_type           = 1
  name                 = "avx-${var.name}-transit"
  region               = var.region
  cidr                 = var.cidr
  account_name         = var.account
  aviatrix_firenet_vpc = false
  aviatrix_transit_vpc = true
}

# Single Transit GW
resource "aviatrix_transit_gateway" "single" {
  count              = var.ha_gw ? 0 : 1
  enable_active_mesh = var.active_mesh
  cloud_type         = 1
  vpc_reg            = var.region
  gw_name            = "avx-${var.name}-transit"
  gw_size            = var.instance_size
  vpc_id             = aviatrix_vpc.default.vpc_id
  account_name       = var.account
  subnet             = var.insane_mode ? cidrsubnet(aviatrix_vpc.default.cidr, 10, 4) : aviatrix_vpc.default.subnets[4].cidr
  connected_transit  = var.connected_transit
  insane_mode        = var.insane_mode
  insane_mode_az     = "${var.region}${var.az1}"
  ha_insane_mode_az  = "${var.region}${var.az2}"
}

# HA Transit GW
resource "aviatrix_transit_gateway" "ha" {
  count              = var.ha_gw ? 1 : 0
  enable_active_mesh = var.active_mesh
  cloud_type         = 1
  vpc_reg            = var.region
  gw_name            = "avx-${var.name}-transit"
  gw_size            = var.instance_size
  vpc_id             = aviatrix_vpc.default.vpc_id
  account_name       = var.account
  subnet             = var.insane_mode ? cidrsubnet(aviatrix_vpc.default.cidr, 10, 4) : aviatrix_vpc.default.subnets[4].cidr
  ha_subnet          = var.insane_mode ? cidrsubnet(aviatrix_vpc.default.cidr, 10, 8) : aviatrix_vpc.default.subnets[6].cidr
  ha_gw_size         = var.instance_size
  connected_transit  = var.connected_transit
  insane_mode        = var.insane_mode
  insane_mode_az     = "${var.region}${var.az1}"
  ha_insane_mode_az  = "${var.region}${var.az2}"
}

