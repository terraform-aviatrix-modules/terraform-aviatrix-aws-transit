#Transit VPC
resource "aviatrix_vpc" "default" {
  cloud_type           = 1
  name                 = local.name
  region               = var.region
  cidr                 = var.cidr
  account_name         = var.account
  aviatrix_firenet_vpc = false
  aviatrix_transit_vpc = true
}

#Transit GW
resource "aviatrix_transit_gateway" "default" {
  enable_active_mesh               = var.active_mesh
  cloud_type                       = 1
  vpc_reg                          = var.region
  gw_name                          = local.name
  gw_size                          = var.instance_size
  vpc_id                           = aviatrix_vpc.default.vpc_id
  account_name                     = var.account
  subnet                           = local.subnet
  ha_subnet                        = var.ha_gw ? local.ha_subnet : null
  ha_gw_size                       = var.ha_gw ? var.instance_size : null
  connected_transit                = var.connected_transit
  enable_hybrid_connection         = var.hybrid_connection
  bgp_manual_spoke_advertise_cidrs = var.bgp_manual_spoke_advertise_cidrs
  enable_learned_cidrs_approval    = var.learned_cidr_approval
  insane_mode                      = var.insane_mode
  insane_mode_az                   = local.insane_mode_az
  ha_insane_mode_az                = var.ha_gw ? local.ha_insane_mode_az : null
  enable_segmentation              = var.enable_segmentation
  single_az_ha                     = var.single_az_ha
  single_ip_snat                   = var.single_ip_snat
  enable_advertise_transit_cidr    = var.enable_advertise_transit_cidr
  enable_firenet                   = var.enable_firenet
  enable_transit_firenet           = var.enable_transit_firenet
  enable_egress_transit_firenet    = var.enable_egress_transit_firenet
  bgp_polling_time                 = var.bgp_polling_time
  bgp_ecmp                         = var.bgp_ecmp
  local_as_number                  = var.local_as_number
  enable_bgp_over_lan              = var.enable_bgp_over_lan
  enable_encrypt_volume            = var.enable_encrypt_volume
  customer_managed_keys            = var.customer_managed_keys
}
