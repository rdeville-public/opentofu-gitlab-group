# Groups settings variables
# ------------------------------------------------------------------------
variable "settings_path" {
  type        = string
  description = "Path of the group"
}

variable "settings_name" {
  type        = string
  description = "Name of the group"
}

variable "settings_description" {
  type        = string
  description = "Group description"
}

variable "settings_parent_id" {
  type        = string
  description = "ID of the parent group (creates a nested group)."

  default = null
}

variable "settings_auto_devops_enabled" {
  type        = bool
  description = "Default to Auto DevOps pipeline for all projects within this group"

  nullable = false
  default  = false
}

variable "settings_avatar" {
  type        = string
  description = "A local path to the avatar image to upload."

  default = null
}

variable "settings_default_branch_protection" {
  type        = number
  description = "See https://docs.gitlab.com/ee/api/groups.html#options-for-default_branch_protection."

  nullable = false
  default  = 4
}

variable "settings_emails_enabled" {
  type        = bool
  description = "Enable email notifications."

  nullable = false
  default  = false
}

variable "settings_ip_restriction_ranges" {
  type        = list(string)
  description = <<-EOM
  A list of IP addresses or subnet masks to restrict group access.
  Will be concatenated together into a comma separated string.
  Only allowed on top level groups.
  EOM

  default = null
}

variable "settings_lfs_enabled" {
  type        = bool
  description = "Enable/disable Large File Storage (LFS) for the projects in this group."

  nullable = false
  default  = false
}

variable "settings_membership_lock" {
  type        = bool
  description = "Users cannot be added to projects in this group."

  nullable = false
  default  = true
}

variable "settings_mentions_disabled" {
  type        = bool
  description = "Disable the capability of a group from getting mentioned."

  nullable = false
  default  = true
}

variable "settings_permanently_remove_on_delete" {
  type        = bool
  description = <<-EOM
  Whether the group should be permanently removed during a delete operation.
  This only works with subgroups.
  Must be configured via an apply before the destroy is run.
  EOM

  nullable = false
  default  = false
}

variable "settings_prevent_forking_outside_group" {
  type        = bool
  description = <<-EOM
  When enabled, users can not fork projects from this group to external
  namespaces.
  EOM

  nullable = false
  default  = false
}

variable "settings_project_creation_level" {
  type        = string
  description = "Determine if developers can create projects in the group."

  nullable = false
  default  = "noone"
}

variable "settings_request_access_enabled" {
  type        = bool
  description = "Allow users to request member access."

  nullable = false
  default  = false
}

variable "settings_require_two_factor_authentication" {
  type        = bool
  description = "Require all users in this group to setup Two-factor authentication."

  nullable = false
  default  = true
}

variable "settings_share_with_group_lock" {
  type        = bool
  description = "Prevent sharing a project with another group within this group."

  nullable = false
  default  = true
}

variable "settings_shared_runners_setting" {
  type        = string
  description = "Enable or disable shared runners for a group’s subgroups and projects."

  nullable = false
  default  = "disabled_and_unoverridable"
}

variable "settings_subgroup_creation_level" {
  type        = string
  description = "Allowed to create subgroups. Valid values are: owner, maintainer."

  nullable = false
  default  = "owner"
}

variable "settings_two_factor_grace_period" {
  type        = number
  description = "Time before Two-factor authentication is enforced (in hours)."

  nullable = false
  default  = 72
}

variable "settings_visibility_level" {
  type        = string
  description = "The group's visibility. Can be private, internal, or public"

  nullable = false
  default  = "private"
}

variable "settings_wiki_access_level" {
  type        = string
  description = "The group's wiki access level. Only available on Premium and Ultimate plans. Valid values are disabled, private, enabled."

  nullable = false
  default  = "disabled"
}

variable "settings_push_rules" {
  type = object({
    author_email_regex            = optional(string)
    branch_name_regex             = optional(string)
    commit_committer_check        = optional(bool)
    commit_committer_name_check   = optional(bool)
    commit_message_negative_regex = optional(string)
    commit_message_regex          = optional(string)
    deny_delete_tag               = optional(bool)
    file_name_regex               = optional(string)
    max_file_size                 = optional(number)
    member_check                  = optional(bool)
    prevent_secrets               = optional(bool)
    reject_unsigned_commits       = optional(bool)
  })
  description = <<-EOM
  Object describing push rules with following structure:
  * `author_email_regex`: String, optional, all commit author emails must match
    this regex.
  * `branch_name_regex`: String, optional, all branch names must match this regex.
  * `commit_committer_check`: Boolean, optional, only commits pushed using
    verified emails are allowed.
    Note This attribute is only supported in GitLab versions >= 16.4.
  * `commit_committer_name_check`: Boolean, optional, users can only push
    commits to this repository if the commit author name is consistent with
    their GitLab account name.
  * `commit_message_negative_regex`: String, optional, no commit message is
    allowed to match this regex.
  * `commit_message_regex`: String, optional, all commit messages must match
    this regex.
  * `deny_delete_tag`: Boolean, optional, deny deleting a tag.
  * `file_name_regex`: String, optional, filenames matching the regular
    expression provided in this attribute are not allowed.
  * `max_file_size`: Number, optional, maximum file size (MB) allowed.
  * `member_check`: Boolean, optional, allows only GitLab users to author commits.
  * `prevent_secrets`: Boolean, optional, gitLab will reject any files that
    are likely to contain secrets.
  * `reject_unsigned_commits`: Boolean, optional, only commits signed through
    GPG are allowed.
    Note This attribute is only supported in GitLab versions >= 16.4.

  EOM

  nullable = false
  default  = {}
}

# Groups labels variables
# ------------------------------------------------------------------------
variable "labels" {
  # Key is the name of the label
  type = map(object({
    color       = string
    description = optional(string)
  }))
  description = <<-EOM
  Map of objects, where key is the name of the label, describing labels with
  following structure:
  * `color`: String, the color of the label given in 6-digit hex notation with
    leading '#' sign (e.g. `#FFAABB`) or one of the CSS color names.
  * `description`: String, optional, the description of the label.
  EOM

  nullable = false
  default  = {}
}

# Groups CI variables variables
# ------------------------------------------------------------------------
variable "variables" {
  type = map(object({
    value             = string
    environment_scope = optional(string)
    masked            = optional(bool)
    protected         = optional(bool)
    raw               = optional(bool)
    variable_type     = optional(string)
  }))
  description = <<-EOM
  Map of objects, where key is the name of the variables, describing variables
  with following structure:
  * `value`: String, the value of the variable.
  * `description`: String, optional, the description of the variable.
  * `environment_scope`: String, optional, the environment scope of the variable.
    Defaults to all environment (*).
    Note that in Community Editions of Gitlab, values other than * will cause inconsistent plans.
  * `masked`: Boolean, optional, if set to true, the value of the variable will
    be hidden in job logs.
    The value must meet the masking requirements.
  * `protected`: Boolean, optional, if set to true, the variable will be passed
    only to pipelines running on protected branches and tags.
  * `raw`: Boolean, optional, whether the variable is treated as a raw string.
    When true, variables in the value are not expanded.
  * `variable_type`: String, optional, the type of a variable.
    Valid values are: env_var, file.
  EOM

  nullable = false
  default  = {}
}

variable "access_token" {
  type = map(object({
    expires_at   = string
    scopes       = set(string)
    access_level = optional(string, "no one")
    rotation_configuration = object({
      expiration_days    = number
      rotate_before_days = number
    })
  }))
  description = <<-EOM
  Map of objects, where key is the name of the access token, describing access
  token configuration with following structure:
  * `scopes`: Set of string, the scopes of the group access token.
    See: [Groups Access Token - Scopes](https://docs.gitlab.com/ee/user/group/settings/group_access_tokens.html#scopes-for-a-group-access-tokenValid)
  * `access_level`:, String, optional, the access level for the group access token.
    Valid values are: no one, minimal, guest, reporter, developer, maintainer, owner.
    See: [Permissions and roles](https://docs.gitlab.com/ee/user/permissions.html)
    Default is `no one`.
  * `expires_at`:, String, optional, when the token will expire, YYYY-MM-DD format.
  * `rotation_configuration`:, Object, optional, The configuration for when
    to rotate a token automatically. Will not rotate a token until terraform apply
    is run.
    Object with the following structure:
      * `expiration_days`: Number, the duration (in days) the new token should be
        valid for.
      * `rotate_before_days`: Number, the duration (in days) before the expiration
        when the token should be rotated.
  EOM

  nullable = false
  default  = {}
}
