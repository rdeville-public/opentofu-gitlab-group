# Configure the GitLab Provider
terraform {
  required_version = ">= 1.8, < 2.0"
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~>18.0"
    }
  }
}
