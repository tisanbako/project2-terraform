variable "vpc_cidr" {.
    description = "cidr of the vpc"
    type = string
    default = "10.1.0.0/16"
}

variable "az" {
    description = "az of for the resources"
    type = list
    default = ["us-east-1a", "us-east-1b"]
}

variable "public1_sub_cidr" {
       description = "public1 subnet cidr"
    type = list
    default = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "public2_sub_cidr" {
    description = "public2 subnet cidr"
    type = list
    default = ["10.1.3.0/24", "10.1.4.0/24"]
}

variable "private1_sub_cidr" {
    description = "private1 subnet cidr"
    type = list
    default = ["10.1.5.0/24", "10.1.6.0/24"]
}

variable "private2_sub_cidr" {
    description = "private2 subnet cidr"
    type = list
    default = ["10.1.7.0/24", "10.1.8.0/24"]
}

