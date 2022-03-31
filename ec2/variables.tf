variable "name" {
  description = "Name of EC2 instance."
  type        = string
}

variable "region" {
  description = "The region the EC2 instance should be created in."
  type        = string
}

variable "public_key" {
  description = "The default public key of the key used to log into the EC2 instance with."
  type        = string
}

variable "instance_type" {
  description = "The default instance type."
  type        = string
}

variable "subnet_id" {
  description = "The Subnet ID to launch the instance in. Will use the default subnet in teh default VPC if omitted."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to add to the resource."
  type        = map(string)
  default     = {}
}

variable "credentials" {
  description = "The credentials for connecting to AWS."
  type = object({
    access_key = string
    secret_key = string
  })
  sensitive = true
}

# Resource Inputs from the workload resource type.

variable "spec" {
  description = "The workload details"
  type        = any

  validation {
    condition     = can(regex("^ami-", var.spec.containers[keys(var.spec.containers)[0]].image))
    error_message = "Image specified does not appear to be a valid AMI ID."
  }

  validation {
    condition     = length(keys(var.spec.containers)) == 1
    error_message = "There must be exactly 1 container in the workload."
  }
}

variable "profile" {
  description = "The Workload Profile of the workload"
  type        = string

  validation {
    condition     = can(regex("/ec2$", var.profile))
    error_message = "Workload profile is not \"ec2\"."
  }
}

variable "id" {
  description = "The ID of the workload"
  type        = string
}
