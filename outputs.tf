output "id" {
  value       = gitlab_group.this.id
  description = "The generated group ID"
}

output "name" {
  value       = gitlab_group.this.name
  description = "The group name"
}

output "path" {
  value       = gitlab_group.this.path
  description = "The group path"
}

output "full_path" {
  value       = gitlab_group.this.full_path
  description = "The group path"
}
