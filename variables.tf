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
  default     = "t3.small"
}

variable "ha_gw" {
  description = "Boolean to determine if module will be deployed in HA or single mode"
  type        = bool
  default     = true
}

variable "insane_mode" {
  type    = bool
  default = false
}

variable "az1" {
  type    = string
  default = "a"
}

variable "az2" {
  type    = string
  default = "b"
}

variable "name" {
  type = string
}

variable "connected_transit" {
  description = ""
  type        = bool
  default     = true
}

variable "active_mesh" {
  description = ""
  type        = bool
  default     = true
}
