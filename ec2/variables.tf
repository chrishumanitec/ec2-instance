variable "name" {
  description = "Name of EC2 instance."
  type        = string
}

variable "region" {
  description = "The region the EC2 instance should be created in."
  type        = string
}

variable "public_key" {
  description = "The public key of the key used to log into the EC2 instance with."
  type        = string
}

variable "credentials" {
  description = "The credentials for connecting to AWS."
  type = object({
    access_key = string
    secret_key = string
  })
  sensitive = true
}
