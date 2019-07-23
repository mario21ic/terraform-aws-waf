variable "region" {
  description = "AWS Region"
}

variable "name" {
  description = "The name"
}

variable "env" {
  description = "Environment name, example: bmdev"
}

variable "action_default" {}
variable "action" {}
variable "priority" {}
variable "ip" {}

variable "resource_qty" {
  description = "resource arn to target"
}

variable "resource_arns" {
  type = "list"
  default = []
}