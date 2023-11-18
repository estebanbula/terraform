variable "cluster_name" {
    type = string
    default = "eks-jam-challenge-1"
}

variable "cluster_version" {
  type = string
  default = "1.24"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "10.0.0.0/16"
}