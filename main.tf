# Manage settings of the group.
resource "gitlab_group" "this" {
  path        = var.settings_path
  name        = var.settings_name
  description = var.settings_description
  parent_id   = var.settings_parent_id

  auto_devops_enabled               = var.settings_auto_devops_enabled
  avatar                            = var.settings_avatar
  avatar_hash                       = filesha256(var.settings_avatar)
  default_branch_protection         = var.settings_default_branch_protection
  emails_enabled                    = var.settings_emails_enabled
  lfs_enabled                       = var.settings_lfs_enabled
  ip_restriction_ranges             = var.settings_ip_restriction_ranges
  membership_lock                   = var.settings_membership_lock
  mentions_disabled                 = var.settings_mentions_disabled
  permanently_remove_on_delete      = var.settings_parent_id != null ? var.settings_permanently_remove_on_delete : null
  prevent_forking_outside_group     = var.settings_prevent_forking_outside_group
  project_creation_level            = var.settings_project_creation_level
  request_access_enabled            = var.settings_request_access_enabled
  require_two_factor_authentication = var.settings_require_two_factor_authentication
  share_with_group_lock             = var.settings_share_with_group_lock
  shared_runners_setting            = var.settings_shared_runners_setting
  subgroup_creation_level           = var.settings_subgroup_creation_level
  two_factor_grace_period           = var.settings_two_factor_grace_period
  visibility_level                  = var.settings_visibility_level
  wiki_access_level                 = var.settings_wiki_access_level

  dynamic "push_rules" {
    for_each = var.settings_push_rules

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

# Manage labels of a group.
resource "gitlab_group_label" "this" {
  for_each = var.labels

  group       = gitlab_group.this.id
  name        = each.key
  color       = each.value.color
  description = each.value.description
}

# Manage CI/CD variable for a group.
resource "gitlab_group_variable" "this" {
  for_each = var.variables

  group = gitlab_group.this.name
  key   = each.key
  value = each.value.value

  environment_scope = each.value.environment_scope
  masked            = each.value.masked
  protected         = each.value.protected
  raw               = each.value.raw
  variable_type     = each.value.variable_type
}

# Manage a group access token.
resource "gitlab_group_access_token" "this" {
  for_each = var.access_tokens

  group      = gitlab_group.this.name
  name       = each.key
  expires_at = each.value.expires_at
  scopes     = each.value.scopes

  access_level           = each.value.access_level
  rotation_configuration = each.value.rotation_configuration
}

# Manage group membership
resource "gitlab_group_membership" "this" {
  for_each = local.membership

  group_id                      = gitlab_group.this.id
  user_id                       = each.key
  access_level                  = each.value
  expires_at                    = var.membership[each.value][each.key].expires_at
  skip_subresources_on_destroy  = var.membership[each.value][each.key].skip_subresources_on_destroy
  unassign_issuables_on_destroy = var.membership[each.value][each.key].unassign_issuables_on_destroy
}

# Manage group badges
resource "gitlab_group_badge" "this" {
  for_each = var.badges

  group     = gitlab_group.this.id
  name      = each.key
  image_url = each.value.image_url
  link_url  = each.value.link_url
}
