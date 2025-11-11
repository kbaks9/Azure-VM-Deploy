
variable "resource_group" {
  default = "rg-grp"
  description = "Resource group name is app-grp"
}

variable "resource_location" {
    default = "North Europe"
    description = "This sets location for the instance"  
}

variable "my_ip" {
  type = string
  description = "This is my IP address"
}
