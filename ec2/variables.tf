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


variable "spec" {
  description = "The workload details"
  type = object({
    containers = object({
      image = object({
        files         = map(any)
        id            = string
        image         = string
        resources     = map(any)
        variables     = map(string)
        volume_mounts = map(any)
      })
    })
  })
}

variable "profile" {
  description = "The Workload Profile of the workload"
  type        = string
}

variable "id" {
  description = "The ID of the workload"
  type        = string
}
