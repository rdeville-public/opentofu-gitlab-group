output "group_id" {
  value       = gitlab_group.this.id
  description = "The generated group ID"
}

output "group_name" {
  value       = gitlab_group.this.name
  description = "The group name"
}
