// Manage the lifecycle of a group.
resource "gitlab_group" "this" {
  path        = var.group_path
  name        = var.group_name
  description = var.group_description
  parent_id   = var.group_parent_id

  auto_devops_enabled               = var.group_auto_devops_enabled
  avatar                            = var.group_avatar
  avatar_hash                       = var.group_avatar_hash
  default_branch_protection         = var.group_default_branch_protection
  emails_enabled                    = var.group_emails_enabled
  lfs_enabled                       = var.group_lfs_enabled
  ip_restriction_ranges             = var.group_ip_restriction_ranges
  membership_lock                   = var.group_membership_lock
  mentions_disabled                 = var.group_mentions_disabled
  prevent_forking_outside_group     = var.group_prevent_forking_outside_group
  project_creation_level            = var.group_project_creation_level
  permanently_remove_on_delete      = var.group_permanently_remove_on_delete
  request_access_enabled            = var.group_request_access_enabled
  require_two_factor_authentication = var.group_require_two_factor_authentication
  share_with_group_lock             = var.group_share_with_group_lock
  shared_runners_setting            = var.group_shared_runners_setting
  subgroup_creation_level           = var.group_subgroup_creation_level
  two_factor_grace_period           = var.group_two_factor_grace_period
  visibility_level                  = var.group_visibility_level
  wiki_access_level                 = var.group_wiki_access_level

  dynamic "push_rules" {
    for_each = var.group_push_rules

    content {
      branch_name_regex       = push_rules.value.branch_name_regex
      commit_committer_check  = push_rules.value.commit_committer_check
      deny_delete_tag         = push_rules.value.deny_delete_tag
      max_file_size           = push_rules.value.max_file_size
      member_check            = push_rules.value.member_check
      prevent_secrets         = push_rules.value.prevent_secrets
      reject_unsigned_commits = push_rules.value.reject_unsigned_commits
    }
  }
}

// Manage the lifecycle of labels within a group.
resource "gitlab_group_label" "this" {
  for_each = var.group_labels

  group       = gitlab_group.this.id
  name        = each.key
  color       = each.value.color
  description = each.value.description
}

// Manage the lifecycle of a CI/CD variable for a group.
resource "gitlab_group_variable" "this" {
  for_each = var.group_variables

  group = gitlab_group.this.name
  key   = each.key
  value = each.value.value

  environment_scope = each.value.environment_scope
  masked            = each.value.masked
  protected         = each.value.protected
  raw               = each.value.raw
  variable_type     = each.value.variable_type
}

// Manage the lifecycle of a group access token.
resource "gitlab_group_access_token" "this" {
  for_each = var.group_access_tokens

  group      = gitlab_group.this.name
  name       = each.key
  expires_at = each.value.expires_at
  scopes     = each.value.scopes

  access_level           = each.value.access_level
  rotation_configuration = each.value.rotation_configuration
}
