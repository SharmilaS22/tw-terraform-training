variable "def_region" {
  type    = string
  default = "us-east-2"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "ami_linux" {
  type    = string
  default = "ami-0fa399d9c130ec923" //Ohio - amazon linux
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_name" {
  type    = string
  default = "Sharmi-instance"
}

variable "user_data_script_path" {
  type    = string
  default = "./user-data.sh"
}

variable "key_pair_name" {
  type    = string
  default = "sample-kp"
}

variable "key_pair_pem_path" {
  type    = string
  default = "/path/to/pem/file/sample-kp.pem"
}

variable "sg_ports" {
  type    = list(number)
  default = [22, 80, 443]
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.0.0/26"
}

variable "public_subnet_az" {
  type    = string
  default = "us-east-2a"
}

variable "asg_min_size" {
  type    = number
  default = 1 //TODO 2
}

variable "asg_max_size" {
  type    = number
  default = 1 //TODO 3
}