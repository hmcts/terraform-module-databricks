variable "existing_resource_group_name" {
  description = "Name of existing resource group to deploy resources into"
  type        = string
  default     = null
}

variable "location" {
  description = "Target Azure location to deploy the resource"
  type        = string
  default     = "UK South"
}

variable "name" {
  description = "The default name will be product+component+env, you can override the product+component part by setting this"
  type        = string
  default     = null
}

variable "sku" {
  description = "The SKU to deploy databricks with. Defaults to 'premium'."
  type        = string
  default     = "premium"
}

variable "managed_resource_group_name" {
  description = "The name of the databricks managed resource group. Defaults to null and will be based off of the name of the databricks workspace."
  type        = string
  default     = null
}

variable "no_public_ip" {
  description = "Whether or not the databricks workspace should have a public endpoint."
  type        = bool
  default     = false
}

variable "infrastructure_encryption_enabled" {
  description = "Whether or not to enable infrastructure encryption."
  type        = bool
  default     = false
}

variable "vnet_id" {
  description = "The ID of the virtual network."
  type        = string
  default     = null
}

variable "public_subnet_name" {
  description = "The the name of the public subnet."
  type        = string
  default     = null
}

variable "public_subnet_nsg_id" {
  description = "The the ID of the NSG associated with the public subnet."
  type        = string
  default     = null
}

variable "private_subnet_name" {
  description = "The the name of the public subnet."
  type        = string
  default     = null
}

variable "private_subnet_nsg_id" {
  description = "The the ID of the NSG associated with the public subnet."
  type        = string
  default     = null
}
