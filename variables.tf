variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "demo"
}

variable "type" {
  default = "t2.small.elasticsearch"
}

variable "vpc_id" {
  default = ""
}

variable "vpc_cidr" {
  default = "10.88.0.0/16"
}

variable "base_domain" {
  default = "nalbam.com"
}
