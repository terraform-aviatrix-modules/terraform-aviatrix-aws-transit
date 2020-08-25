# Module Aviatrix Transit VPC for AWS

### Description
This module deploys a VPC and a set of Aviatrix transit gateways.

### Diagram
<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-aws-transit/blob/master/img/aws-ha.png?raw=true"  height="250">

with ha_gw set to false, the following will be deployed:

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-aws-transit/blob/master/img/aws-single.png?raw=true"  height="250">

### Usage Example
```
module "transit_aws_1" {
  source  = "terraform-aviatrix-modules/aws-transit/aviatrix"
  version = "v1.0.2"

  cidr = "10.1.0.0/20"
  region = "eu-west-1"
  account = "AWS"
}
```

### Variables
The following variables are required:

key | value
--- | ---
name | avx-\<name\>-transit
region | AWS region to deploy the transit VPC in
account | The AWS accountname on the Aviatrix controller, under which the controller will deploy this VPC
cidr | The IP CIDR wo be used to create the VPC.

The following variables are optional:

key | default | value
--- | --- | ---
instance_size | t3.small | Size of the transit gateway instances
ha_gw | true | Set to true to false te deploy a single transit GW.
insane_mode | false | Set to true to enable insane mode encryption
az1 | "a" | concatenates with region to form az names. e.g. eu-central-1a. Used for insane mode only.
az2 | "b" | concatenates with region to form az names. e.g. eu-central-1b. Used for insane mode only.
connected_transit | true |
active_mesh | true |

### Outputs
This module will return the following objects:

key | description
--- | ---
vpc | The created VPC as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
transit_gateway | The created Aviatrix transit gateway as an object with all of it's attributes.
