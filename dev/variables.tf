variable "instance_name" {
  description = "TerraformApp"
  type        = string
  default     = "ExampleAppServerInstance"
}



variable "region" {
  default = "us-east-1"
}
variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}

variable "cidr_block_vpc" {
  default = "10.0.0.0/16"
}

//VPC
variable "vpc_name_tag" {
  default = "dev"
}

//Public subnet 1
variable "cidr_block_public_1" {
  default = "10.0.1.0/24"
}
variable "az_public_1" {
  default = "us-east-1a"
}

variable "public_1_name_tag" {
  default = "dev-public-1"
}

//Public subnet 2
variable "cidr_block_public_2" {
  default = "10.0.2.0/24"
}
variable "az_public_2" {
  default = "us-east-1b"
}

variable "public_2_name_tag" {
  default = "dev-public-2"
}

//Public subnet 3
variable "cidr_block_public_3" {
  default = "10.0.3.0/24"
}
variable "az_public_3" {
  default = "us-east-1c"
}

variable "public_3_name_tag" {
  default = "dev-public-3"
}

//Private subnet 1
variable "cidr_block_private_1" {
  default = "10.0.4.0/24"
}
variable "az_private_1" {
  default = "us-east-1a"
}

variable "private_1_name_tag" {
  default = "dev-private-1"
}

//Private subnet 2
variable "cidr_block_private_2" {
  default = "10.0.5.0/24"
}
variable "az_private_2" {
  default = "us-east-1b"
}

variable "private_2_name_tag" {
  default = "dev-private-2"
}

//Private subnet 3
variable "cidr_block_private_3" {
  default = "10.0.6.0/24"
}
variable "az_private_3" {
  default = "us-east-1c"
}

variable "private_3_name_tag" {
  default = "dev-private-3"
}

//Internet Gateway
variable "internet_gateway_name_tag" {
  default = "dev"
}

//Public route table
variable "cidr_block_public_route_table" {
  default = "0.0.0.0/0"
}
variable "public_route_table_name_tag" {
  default = "dev-public-1"
}

//Private route table
variable "cidr_block_private_route_table" {
  default = "0.0.0.0/0"
}
variable "private_route_table_name_tag" {
  default = "dev-private-1"
}



variable "instance_type" {
  default = "t2.micro"
}

variable "name_prefix" {
  default = "dev-"
}

variable "ingress1_from" {
  default = 0
}

variable "ingress1_to" {
  default = 65535
}
variable "ingress1_protocol" {
  default = "tcp"
}
variable "ingress1_cidr" {
  default = ["0.0.0.0/0"]
}


variable "ingress2_from" {
  default = 5001
}

variable "ingress2_to" {
  default = 5001
}
variable "ingress2_protocol" {
  default = "tcp"
}
variable "ingress2_cidr" {
  default = ["0.0.0.0/0"]
}




variable "egress2_from" {
  default = 0
}

variable "egress2_to" {
  default = 0
}
variable "egress2_protocol" {
  default = "-1"
}
variable "egress2_cidr" {
  default = ["0.0.0.0/0"]
}


variable "ec2_pubic1_name" {
  default = "public_inst_1"
}
variable "ec2_pubic2_name" {
  default = "public_inst_2"
}



variable "ami" {
  default = ""
}


variable "zone_id" {
  default = ""
}

variable "record_type_A" {
  default = "A"
}

variable "record_name" {
  default = ""
}

variable "record_ttl" {
  default = "300"
}




