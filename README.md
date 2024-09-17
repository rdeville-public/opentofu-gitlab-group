<!-- BEGIN DOTGIT-SYNC BLOCK MANAGED -->
# 👋 Welcome to OpenTofu Module Gitlab Groups

<center>

> ⚠️ IMPORTANT !
>
> Main repo is on [framagit.org](https://framagit.org/rdeville-public/terraform/module-gitlab-groups).
>
> On other online git platforms, they are just mirror of the main repo.
>
> Any issues, pull/merge requests, etc., might not be considered on those other
> platforms.

</center>

---

<center>

[![Licenses: (MIT OR BEERWARE)][license_badge]][license_url]
[![Changelog][changelog_badge]][changelog_badge_url]
[![Build][build_badge]][build_badge_url]
[![Release][release_badge]][release_badge_url]

</center>

[build_badge]: https://framagit.org/rdeville-public/terraform/module-gitlab-groups/badges/main/pipeline.svg
[build_badge_url]: https://framagit.org/rdeville-public/terraform/module-gitlab-groups/-/commits/main
[release_badge]: https://framagit.org/rdeville-public/terraform/module-gitlab-groups/-/badges/release.svg
[release_badge_url]: https://framagit.org/rdeville-public/terraform/module-gitlab-groups/-/releases/
[license_badge]: https://img.shields.io/badge/Licenses-MIT%20OR%20BEERWARE-blue
[license_url]: https://framagit.org/rdeville-public/terraform/module-gitlab-groups/blob/main/LICENSE
[changelog_badge]: https://img.shields.io/badge/Changelog-Python%20Semantic%20Release-yellow
[changelog_badge_url]: https://github.com/python-semantic-release/python-semantic-release

OpenTofu modules allowing to manage gitlab groups configuration.

---
<!-- BEGIN DOTGIT-SYNC BLOCK EXCLUDED CUSTOM_README -->
## 🚀 Usage

### Manage Group with all default settings

```hcl
module "gitlab_group" {
  source = "git::https://framagit.org/rdeville-public/terraform/module-gitlab-groups.git"

  # Required Variables
  path        = "group-name"
  name        = "Group Name"
  description = "Group Description"
}
```

### Manage Group with all settings

```hcl
module "gitlab_group" {
  source = "git::https://framagit.org/rdeville-public/terraform/module-gitlab-groups.git"

  # Required Variables
  settings_path        = "group-name"
  settings_name        = "Group Name"
  settings_description = "Group Description"

  # Default variables
  settings_parent_id           = null
  settings_auto_devops_enabled = false
  settings_avatar              = null

  settings_default_branch_protection         = 4
  settings_emails_enabled                    = false
  settings_ip_restriction_ranges             = null
  settings_lfs_enabled                       = false
  settings_membership_lock                   = true
  settings_mentions_disabled                 = true
  settings_permanently_remove_on_delete      = false
  settings_prevent_forking_outside_group     = false
  settings_project_creation_level            = "noone"
  settings_request_access_enabled            = false
  settings_require_two_factor_authentication = true
  settings_share_with_group_lock             = true
  settings_shared_runners_setting            = "disabled_and_unoverridable"
  settings_subgroup_creation_level           = "owner"
  settings_two_factor_grace_period           = 72
  settings_visibility_level                  = "private"
  settings_wiki_access_level                 = "disabled"
  # This variable have multiple keys, see variable.tf for more informations or
  # below in this README
  settings_push_rules                        = {}
}
```

### Manage Group labels

```hcl
module "gitlab_group" {
  source = "git::https://framagit.org/rdeville-public/terraform/module-gitlab-groups.git"

  # Required Variables
  settings_path        = "group-name"
  settings_name        = "Group Name"
  settings_description = "Group Description"

  # Minimal Example value, see README below for more details
  labels = {
    "Label Name" = {
      color = "#ff0000"
    }
  }
}
```

### Manage Group variables

```hcl
module "gitlab_group" {
  source = "git::https://framagit.org/rdeville-public/terraform/module-gitlab-groups.git"

  # Required Variables
  settings_path        = "group-name"
  settings_name        = "Group Name"
  settings_description = "Group Description"

  # Minimal Example value, see README below for more details
  variables = {
    "VAR_NAME" = {
      value = "Variable value"
    }
  }
}
```

### Manage Group access tokens

```hcl
module "gitlab_group" {
  source = "git::https://framagit.org/rdeville-public/terraform/module-gitlab-groups.git"

  # Required Variables
  settings_path        = "group-name"
  settings_name        = "Group Name"
  settings_description = "Group Description"

  # Minimal Example value, see README below for more details
  access_tokens = {
    "ACCESS_TOKEN" = {
      scopes =["api"]
      expires_at = "YYYY-MM-DD"
    }
  }
}
```

### Manage Group membership

```hcl
module "gitlab_group" {
  source = "git::https://framagit.org/rdeville-public/terraform/module-gitlab-groups.git"

  # Required Variables
  settings_path        = "group-name"
  settings_name        = "Group Name"
  settings_description = "Group Description"

  # Minimal Example value, see README below for more details
  membership = {
    minimal = {
      "0000" = {}
    }
    guest = {
      "1111" = {}
    }
    reporter = {
      "2222" = {}
    }
    developer = {
      "3333" = {}
    }
    maintainer = {
      "4444" = {}
    }
    owner = {
      "5555" = {}
    }
  }
}
```

### Manage Group membership with higher access privileged

There is a mechanism such that if a user ID is in multiple roles, then the
higher access level is applied, except if attribute `expires_at` for this user
is already a previous day, then higher remaining access level is applied.

This can be useful for instance when providing temporarly greater access level
to a user while minimizing the amount of action needed and setting a deadline
to when the access level is removed.

```hcl
module "gitlab_group" {
  source = "git::https://framagit.org/rdeville-public/terraform/module-gitlab-groups.git"

  # Required Variables
  settings_path        = "group-name"
  settings_name        = "Group Name"
  settings_description = "Group Description"

  # Minimal Example value, see README below for more details
  # Assuming the day you run your apply is the 1st january of 2020, i.e. `2020-01-01`
  membership = {
    minimal = {
      "0000" = {}
      "1111" = {}
    }
    guest = {
      "1111" = {}
      "4444" = {}
    }
    developer = {
      "2222" = {}
      "3333" = {}
      "4444" = {}
    }
    maintainer = {
      "3333" = {
        expires_at = "2020-12-31"
      }
      "4444" = {
        expires_at = "2019-12-31"
      }
    }
  }
}
```

This will provide `minimal` access to user `0000`, `guest` access to user `1111`,
developer access to users `2222` and `4444` and `maintainer` access to user
`3333` until the 31th december of 2020, then user `3333` access level will be
revoked to `developer`.

<!-- BEGIN TF-DOCS -->
## ⚙️ Module Content

<details><summary>Click to reveal</summary>

### Table of Content

* [Requirements](#requirements)
* [Resources](#resources)
* [Inputs](#inputs)
  * [Required Inputs](#required-inputs)
  * [Optional Inputs](#optional-inputs)
* [Outputs](#outputs)

### Requirements

* [opentofu](https://opentofu.org/docs/):
  `>= 1.8, < 2.0`
* [gitlab](https://registry.terraform.io/providers/gitlabhq/gitlab/):
  `~>17.0`

### Resources

* [resource.gitlab_group.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group)
  > Manage settings of the group.
* [resource.gitlab_group_access_token.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_access_token)
  > Manage a group access token.
* [resource.gitlab_group_label.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_label)
  > Manage labels of a group.
* [resource.gitlab_group_membership.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_membership)
  > Manage group membership
* [resource.gitlab_group_variable.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_variable)
  > Manage CI/CD variable for a group.

<!-- markdownlint-capture -->
### Inputs

<!-- markdownlint-disable -->
#### Required Inputs

* [settings_path](#settings_path)
* [settings_name](#settings_name)
* [settings_description](#settings_description)

##### `settings_path`

Path of the group
<div style="display:inline-block;width:100%;">
<div style="float:left;border-color:#FFFFFF;width:75%;">
<details><summary>Type</summary>

```hcl
string
```

</details>
</div>
</div>

##### `settings_name`

Name of the group
<div style="display:inline-block;width:100%;">
<div style="float:left;border-color:#FFFFFF;width:75%;">
<details><summary>Type</summary>

```hcl
string
```

</details>
</div>
</div>

##### `settings_description`

Group description
<div style="display:inline-block;width:100%;">
<div style="float:left;border-color:#FFFFFF;width:75%;">
<details><summary>Type</summary>

```hcl
string
```

</details>
</div>
</div>

#### Optional Inputs

* [settings_parent_id](#settings_parent_id)
* [settings_auto_devops_enabled](#settings_auto_devops_enabled)
* [settings_avatar](#settings_avatar)
* [settings_default_branch_protection](#settings_default_branch_protection)
* [settings_emails_enabled](#settings_emails_enabled)
* [settings_ip_restriction_ranges](#settings_ip_restriction_ranges)
* [settings_lfs_enabled](#settings_lfs_enabled)
* [settings_membership_lock](#settings_membership_lock)
* [settings_mentions_disabled](#settings_mentions_disabled)
* [settings_permanently_remove_on_delete](#settings_permanently_remove_on_delete)
* [settings_prevent_forking_outside_group](#settings_prevent_forking_outside_group)
* [settings_project_creation_level](#settings_project_creation_level)
* [settings_request_access_enabled](#settings_request_access_enabled)
* [settings_require_two_factor_authentication](#settings_require_two_factor_authentication)
* [settings_share_with_group_lock](#settings_share_with_group_lock)
* [settings_shared_runners_setting](#settings_shared_runners_setting)
* [settings_subgroup_creation_level](#settings_subgroup_creation_level)
* [settings_two_factor_grace_period](#settings_two_factor_grace_period)
* [settings_visibility_level](#settings_visibility_level)
* [settings_wiki_access_level](#settings_wiki_access_level)
* [settings_push_rules](#settings_push_rules)
* [labels](#labels)
* [variables](#variables)
* [access_tokens](#access_tokens)
* [membership](#membership)


##### `settings_parent_id`

ID of the parent group (creates a nested group).
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  string
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  null
  ```

  </div>
</details>

##### `settings_auto_devops_enabled`

Default to Auto DevOps pipeline for all projects within this group
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  false
  ```

  </div>
</details>

##### `settings_avatar`

A local path to the avatar image to upload.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  string
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  null
  ```

  </div>
</details>

##### `settings_default_branch_protection`

See https://docs.gitlab.com/ee/api/groups.html#options-for-default_branch_protection.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  number
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  4
  ```

  </div>
</details>

##### `settings_emails_enabled`

Enable email notifications.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  false
  ```

  </div>
</details>

##### `settings_ip_restriction_ranges`

A list of IP addresses or subnet masks to restrict group access.
Will be concatenated together into a comma separated string.
Only allowed on top level groups.

<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  list(string)
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  null
  ```

  </div>
</details>

##### `settings_lfs_enabled`

Enable/disable Large File Storage (LFS) for the projects in this group.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  false
  ```

  </div>
</details>

##### `settings_membership_lock`

Users cannot be added to projects in this group.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  true
  ```

  </div>
</details>

##### `settings_mentions_disabled`

Disable the capability of a group from getting mentioned.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  true
  ```

  </div>
</details>

##### `settings_permanently_remove_on_delete`

Whether the group should be permanently removed during a delete operation.
This only works with subgroups.
Must be configured via an apply before the destroy is run.

<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  false
  ```

  </div>
</details>

##### `settings_prevent_forking_outside_group`

When enabled, users can not fork projects from this group to external
namespaces.

<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  false
  ```

  </div>
</details>

##### `settings_project_creation_level`

Determine if developers can create projects in the group.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  string
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  noone
  ```

  </div>
</details>

##### `settings_request_access_enabled`

Allow users to request member access.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  false
  ```

  </div>
</details>

##### `settings_require_two_factor_authentication`

Require all users in this group to setup Two-factor authentication.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  true
  ```

  </div>
</details>

##### `settings_share_with_group_lock`

Prevent sharing a project with another group within this group.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  bool
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  true
  ```

  </div>
</details>

##### `settings_shared_runners_setting`

Enable or disable shared runners for a group’s subgroups and projects.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  string
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  disabled_and_unoverridable
  ```

  </div>
</details>

##### `settings_subgroup_creation_level`

Allowed to create subgroups. Valid values are: owner, maintainer.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  string
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  owner
  ```

  </div>
</details>

##### `settings_two_factor_grace_period`

Time before Two-factor authentication is enforced (in hours).
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  number
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  72
  ```

  </div>
</details>

##### `settings_visibility_level`

The group's visibility. Can be private, internal, or public
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  string
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  private
  ```

  </div>
</details>

##### `settings_wiki_access_level`

The group's wiki access level. Only available on Premium and Ultimate plans. Valid values are disabled, private, enabled.
<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  string
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  disabled
  ```

  </div>
</details>

##### `settings_push_rules`

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


<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  object({
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
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  {}
  ```

  </div>
</details>

##### `labels`

Map of objects, where key is the name of the label, describing labels with
following structure:
* `color`: String, the color of the label given in 6-digit hex notation with
  leading '#' sign (e.g. `#FFAABB`) or one of the CSS color names.
* `description`: String, optional, the description of the label.

<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  map(object({
    color       = string
    description = optional(string)
  }))
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  {}
  ```

  </div>
</details>

##### `variables`

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

<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  map(object({
    value             = string
    environment_scope = optional(string)
    masked            = optional(bool)
    protected         = optional(bool)
    raw               = optional(bool)
    variable_type     = optional(string)
  }))
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  {}
  ```

  </div>
</details>

##### `access_tokens`

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

<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  map(object({
    expires_at   = string
    scopes       = set(string)
    access_level = optional(string, "no one")
    rotation_configuration = object({
      expiration_days    = number
      rotate_before_days = number
    })
  }))
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  {}
  ```

  </div>
</details>

##### `membership`

Object, with following attributes:

* `minimal`
* `guest`
* `reporter`
* `developer`
* `maintainer`
* `owner`

Each of the attributes are optional map of object, where key are user ID and
with default values to `{}`.

Above list of attributes represent the access level provided to users in order
of capacity such that users with `minimal` access have less access than user
with `guest` access levelt, etc.

Each user configuration object support following attributes :

* `expires_at`: String, optional, expiration date for the group membership.
  Format: YYYY-MM-DD
* `skip_subresources_on_destroy`: Boolean, optional, whether the deletion of
  direct memberships of the removed member in subgroups and projects should be
  skipped. Only used during a destroy.
* `unassign_issuables_on_destroy`: Boolean, optional, whether the removed
  member should be unassigned from any issues or merge requests inside a given
  group or project. Only used during a destroy.

For instance, with minimal settings:

```hcl
membership = {
  minimal = {
    "0000" = {}
  }
  guest = {
    "1111" = {}
  }
  reporter = {
    "2222" = {}
  }
  developer = {
    "3333" = {}
  }
  maintainer = {
    "4444" = {}
  }
  owner = {
    "5555" = {}
  }
}
```

Provide unlimited `minimal` access level to user with ID `0000`, unlimited
`guest` access to user with ID `1111`, etc.

If a user is set in multiple roles, then the higher access level is applied,
except if attribute `expires_at` for this user is already a previous day, then
higher remaining access level is applied.

This can be useful for instance when providing temporarly greater access level
to a user while minimizing the amount of action needed and setting a deadline
to when the access level is removed.

For instances:

```hcl
# Assuming the day you run your apply is the 1st january of 2020, i.e. `2020-01-01`
membership = {
  minimal = {
    "0000" = {}
    "1111" = {}
  }
  guest = {
    "1111" = {}
    "4444" = {}
  }
  developer = {
    "2222" = {}
    "3333" = {}
    "4444" = {}
  }
  maintainer = {
    "3333" = {
      expires_at = "2020-12-31"
    }
    "4444" = {
      expires_at = "2019-12-31"
    }
  }
}
```

This will provide `minimal` access to user `0000`, `guest` access to user
`1111`, developer access to users `2222` and `4444` and `maintainer` access to
user `3333` until the 31th december of 2020, then user `3333` access level
will be revoked to `developer`.

<details style="width: 100%;display: inline-block">
  <summary>Type & Default</summary>
  <div style="height: 1em"></div>
  <div style="width:64%; float:left;">
  <p style="border-bottom: 1px solid #333333;">Type</p>

  ```hcl
  object({
    minimal = optional(map(object({
      expires_at                    = optional(string)
      skip_subresources_on_destroy  = optional(bool, false)
      unassign_issuables_on_destroy = optional(bool, true)
    })), {})
    guest = optional(map(object({
      expires_at                    = optional(string)
      skip_subresources_on_destroy  = optional(bool, false)
      unassign_issuables_on_destroy = optional(bool, true)
    })), {})
    reporter = optional(map(object({
      expires_at                    = optional(string)
      skip_subresources_on_destroy  = optional(bool, false)
      unassign_issuables_on_destroy = optional(bool, true)
    })), {})
    developer = optional(map(object({
      expires_at                    = optional(string)
      skip_subresources_on_destroy  = optional(bool, false)
      unassign_issuables_on_destroy = optional(bool, true)
    })), {})
    maintainer = optional(map(object({
      expires_at                    = optional(string)
      skip_subresources_on_destroy  = optional(bool, false)
      unassign_issuables_on_destroy = optional(bool, true)
    })), {})
    owner = optional(map(object({
      expires_at                    = optional(string)
      skip_subresources_on_destroy  = optional(bool, false)
      unassign_issuables_on_destroy = optional(bool, true)
    })), {})
  })
  ```

  </div>
  <div style="width:34%;float:right;">
  <p style="border-bottom: 1px solid #333333;">Default</p>

  ```hcl
  {}
  ```

  </div>
</details>
<!-- markdownlint-restore -->

### Outputs

* `group_id`:
  The generated group ID
* `group_name`:
  The group name

</details>

<!-- END TF-DOCS -->
<!-- END DOTGIT-SYNC BLOCK EXCLUDED CUSTOM_README -->
## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check [issues page][issues_pages].

You can also take a look at the [CONTRIBUTING.md][contributing].

[issues_pages]: https://framagit.org/rdeville-public/terraform/module-gitlab-groups/-/issues
[contributing]: https://framagit.org/rdeville-public/terraform/module-gitlab-groups/blob/main/CONTRIBUTING.md

## 👤 Maintainers

* 📧 [**Romain Deville** \<code@romaindeville.fr\>](mailto:code@romaindeville.fr)
  * Website: [https://romaindeville.fr](https://romaindeville.fr)
  * Github: [@rdeville](https://github.com/rdeville)
  * Gitlab: [@r.deville](https://gitlab.com/r.deville)
  * Framagit: [@rdeville](https://framagit.org/rdeville)

## 📝 License

Copyright © 2024 [Romain Deville](code@romaindeville.fr)

This project is under following licenses (**OR**) :

* [MIT][main_license]
* [BEERWARE][beerware_license]

[main_license]: https://framagit.org/rdeville-public/terraform/module-gitlab-groups/blob/main/LICENSE
[beerware_license]: https://framagit.org/rdeville-public/terraform/module-gitlab-groups/blob/main/LICENSE.BEERWARE
<!-- END DOTGIT-SYNC BLOCK MANAGED -->
