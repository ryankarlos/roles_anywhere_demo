variable "cert_domain" {
  type        = string
  default     = "rolesanywhere.com"
  description = "default domain for cert in ACM"
}

variable "role_name" {
  type    = string
  default = "RolesAnywhereRole"
}

variable "trust_anchor_name" {
  type    = string
  default = "DemoTrust"
}


variable "profile_name" {
  type    = string
  default = "DemoProfile"
}


variable "acm_pca_arn" {
  type = string
}


variable s3_policy_arn {
    type = string
}

