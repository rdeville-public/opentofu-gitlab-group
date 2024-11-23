# Configure the GitLab Provider
terraform {
  required_version = ">= 1.8, < 2.0"
  required_providers {
    gitlab = {
      source  = "opentofu/gitlab"
      version = "~>17.0"
    }
  }
}
