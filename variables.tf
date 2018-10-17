variable region {
  default = "ap-northeast-2"
}

variable city {
  default = "SEOUL"
}

variable stage {
  default = "DEV"
}

variable name {
  default = "SRE"
}

variable suffix {
  default = "ELASTICSEARCH"
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
