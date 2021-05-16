# Module Aviatrix Transit VPC for AWS

### Description
This module deploys a VPC and a set of Aviatrix transit gateways.

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v4.0.0 | 0.13 + 0.14 | >=6.4 | >=0.2.19
v3.0.2 | 0.13 | >=6.3 | >=0.2.18
v3.0.1 | 0.13 | >=6.2 | >=0.2.17
v3.0.0 | 0.13 | >=6.2 | >=0.2.17
v2.0.0 | 0.12 | >=6.2 | >=0.2.17

**_Information on older releases can be found in respective release notes._*

### Diagram
<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-aws-transit/blob/master/img/transit-vpc-aws-ha.png?raw=true">

with ha_gw set to false, the following will be deployed:

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-aws-transit/blob/master/img/transit-vpc-aws.png?raw=true">

### Usage Example
```
module "transit_aws_1" {
  source  = "terraform-aviatrix-modules/aws-transit/aviatrix"
  version = "v4.0.0"

  cidr = "10.1.0.0/20"
  region = "eu-west-1"
  account = "AWS"
}
```

### Variables
The following variables are required:

key | value
--- | ---
region | AWS region to deploy the transit VPC in
account | The AWS accountname on the Aviatrix controller, under which the controller will deploy this VPC
cidr | The IP CIDR wo be used to create the VPC.

The following variables are optional:

key | default | value
--- | --- | ---
name | avx-\<region\>-transit | Provide a custom name for VPC and Gateway resources. Result will be avx-\<name\>-transit.
instance_size | t3.medium | Size of the transit gateway instances
ha_gw | true | Set to true to false te deploy a single transit GW.
insane_mode | false | Set to true to enable insane mode encryption
az1 | "a" | concatenates with region to form az names. e.g. eu-central-1a. Used for insane mode only.
az2 | "b" | concatenates with region to form az names. e.g. eu-central-1b. Used for insane mode only.
connected_transit | true | Set to false to disable connected_transit
hybrid_connection | false | Sign of readiness for TGW connection
bgp_manual_spoke_advertise_cidrs | | Intended CIDR list to advertise via BGP. Example: "10.2.0.0/16,10.4.0.0/16" 
learned_cidr_approval | false | Switch to true to enable learned CIDR approval
active_mesh | true | Set to false to disable active_mesh
prefix | true | Boolean to enable prefix name with avx-
suffix | true | Boolean to enable suffix name with -transit
enable_segmentation | false | Switch to true to enable transit segmentation
single_az_ha | true | Set to false if Controller managed Gateway HA is desired
single_ip_snat | false | Enable single_ip mode Source NAT for this container
enable_advertise_transit_cidr  | false | Switch to enable/disable advertise transit VPC network CIDR for a VGW connection
enable_firenet  | false | Sign of readiness for FireNet connection
enable_transit_firenet  | false | Sign of readiness for Transit FireNet connection
enable_egress_transit_firenet  | false | Enable Egress Transit FireNet
bgp_polling_time  | 50 | BGP route polling time. Unit is in seconds
bgp_ecmp  | false | Enable Equal Cost Multi Path (ECMP) routing for the next hop
local_as_number | | Changes the Aviatrix Transit Gateway ASN number before you setup Aviatrix Transit Gateway connection configurations.
enable_bgp_over_lan | false | Enable BGp over LAN. Creates eth4 for integration with SDWAN for example
enable_encrypt_volume | false | Set to true to enable EBS volume encryption for Gateway.
customer_managed_keys | null | Customer managed key ID for EBS Volume encryption.
tunnel_detection_time | null | The IPsec tunnel down detection time for the Spoke Gateway in seconds. Must be a number in the range [20-600]. Default is 60.
tags | null | Map of tags to assign to the gateway.
enable_multi_tier_transit |	false |	Switch to enable multi tier transit

### Outputs
This module will return the following objects:

key | description
--- | ---
vpc | The created VPC as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
transit_gateway | The created Aviatrix transit gateway as an object with all of it's attributes.
