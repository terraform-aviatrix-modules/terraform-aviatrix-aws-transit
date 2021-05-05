variable "region" {
  description = "The AWS region to deploy this module in"
  type        = string
}

variable "cidr" {
  description = "The CIDR range to be used for the VPC"
  type        = string
}

variable "account" {
  description = "The AWS account name, as known by the Aviatrix controller"
  type        = string
}

variable "instance_size" {
  description = "AWS Instance size for the Aviatrix gateways"
  type        = string
  default     = "t3.medium"
}

variable "ha_gw" {
  description = "Boolean to determine if module will be deployed in HA or single mode"
  type        = bool
  default     = true
}

variable "insane_mode" {
  description = "Set to true to enable Aviatrix high performance encryption."
  type        = bool
  default     = false
}

variable "az1" {
  description = "Concatenates with region to form az names. e.g. eu-central-1a. Only used for insane mode"
  type        = string
  default     = "a"
}

variable "az2" {
  description = "Concatenates with region to form az names. e.g. eu-central-1b. Only used for insane mode"
  type        = string
  default     = "b"
}

variable "name" {
  description = "Name for this spoke VPC and it's gateways"
  type        = string
  default     = ""
}

variable "prefix" {
  description = "Boolean to determine if name will be prepended with avx-"
  type        = bool
  default     = true
}

variable "suffix" {
  description = "Boolean to determine if name will be appended with -spoke"
  type        = bool
  default     = true
}

variable "connected_transit" {
  description = "Set to false to disable connected transit."
  type        = bool
  default     = true
}

variable "hybrid_connection" {
  description = "Set to true to prepare Aviatrix transit for TGW connection."
  type        = bool
  default     = false
}

variable "bgp_manual_spoke_advertise_cidrs" {
  description = "Define a list of CIDRs that should be advertised via BGP."
  type        = string
  default     = ""
}

variable "learned_cidr_approval" {
  description = "Set to true to enable learned CIDR approval."
  type        = string
  default     = "false"
}

variable "active_mesh" {
  description = "Set to false to disable active mesh."
  type        = bool
  default     = true
}

variable "enable_segmentation" {
  description = "Switch to true to enable transit segmentation"
  type        = bool
  default     = false
}

variable "single_az_ha" {
  description = "Set to true if Controller managed Gateway HA is desired"
  type        = bool
  default     = true
}

variable "single_ip_snat" {
  description = "Enable single_ip mode Source NAT for this container"
  type        = bool
  default     = false
}

variable "enable_advertise_transit_cidr" {
  description = "Switch to enable/disable advertise transit VPC network CIDR for a VGW connection"
  type        = bool
  default     = false
}

variable "enable_firenet" {
  description = "Sign of readiness for FireNet connection"
  type        = bool
  default     = false
}

variable "enable_transit_firenet" {
  description = "Sign of readiness for Transit FireNet connection"
  type        = bool
  default     = false
}

variable "enable_egress_transit_firenet" {
  description = "Enable Egress Transit FireNet"
  type        = bool
  default     = false
}
variable "bgp_polling_time" {
  description = "BGP route polling time. Unit is in seconds"
  type        = string
  default     = "50"
}

variable "bgp_ecmp" {
  description = "Enable Equal Cost Multi Path (ECMP) routing for the next hop"
  type        = bool
  default     = false
}

variable "local_as_number" {
  description = "Changes the Aviatrix Transit Gateway ASN number before you setup Aviatrix Transit Gateway connection configurations."
  type        = string
  default     = null
}

variable "enable_bgp_over_lan" {
  description = "Enable BGp over LAN. Creates eth4 for integration with SDWAN for example"
  type        = bool
  default     = false
}

variable "enable_encrypt_volume" {
  description = "Enable EBS volume encryption for Gateway. Only supports AWS and AWSGOV. Valid values: true, false. Default value: false."
  type        = bool
  default     = false
}

variable "customer_managed_keys" {
  description = "Customer managed key ID for EBS Volume encryption."
  type        = string
  default     = null
}

locals {
  lower_name        = length(var.name) > 0 ? replace(lower(var.name), " ", "-") : replace(lower(var.region), " ", "-")
  prefix            = var.prefix ? "avx-" : ""
  suffix            = var.suffix ? "-transit" : ""
  name              = "${local.prefix}${local.lower_name}${local.suffix}"
  cidrbits          = tonumber(split("/", var.cidr)[1])
  newbits           = 26 - local.cidrbits
  netnum            = pow(2, local.newbits)
  subnet            = var.insane_mode ? cidrsubnet(var.cidr, local.newbits, local.netnum - 2) : aviatrix_vpc.default.public_subnets[0].cidr
  ha_subnet         = var.insane_mode ? cidrsubnet(var.cidr, local.newbits, local.netnum - 1) : aviatrix_vpc.default.public_subnets[2].cidr
  insane_mode_az    = var.insane_mode ? "${var.region}${var.az1}" : null
  ha_insane_mode_az = var.insane_mode ? "${var.region}${var.az2}" : null
}
