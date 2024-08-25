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

### Minimal usage

```hcl
module "gitlab_group" {
  source = "url-to-module?ref=main"

  group_path = "group-name"
  group_name = "Group Name"
}
```

### Minimal usage of all resource

```hcl
module "gitlab_group" {
  source = "url-to-module?ref=main"

  group_path = "group-name"
  group_name = "Group Name"
  group_labels = {
    "Label Name" = {
      color = "#ff0000"
    }
  }
  group_variables = {
    "VAR_NAME" = {
      value = "Variable value"
    }
  }
  group_access_tokens = {
    "ACCESS_TOKEN" = {
      scopes =["api"]
      expires_at = "YYYY-MM-DD"
    }
  }
}
```

<!-- BEGIN TF-DOCS -->
## ⚙️ Module Content

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
  > Manage the lifecycle of a group.
* [resource.gitlab_group_access_token.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_access_token)
  > Manage the lifecycle of a group access token.
* [resource.gitlab_group_label.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_label)
  > Manage the lifecycle of labels within a group.
* [resource.gitlab_group_variable.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_variable)
  > Manage the lifecycle of a CI/CD variable for a group.

<!-- markdownlint-capture -->
### Inputs

<!-- markdownlint-disable -->
#### Required Inputs

* [group_path](#group_path)
* [group_name](#group_name)

##### `group_path`

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

##### `group_name`

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

#### Optional Inputs

* [group_description](#group_description)
* [group_parent_id](#group_parent_id)
* [group_auto_devops_enabled](#group_auto_devops_enabled)
* [group_avatar](#group_avatar)
* [group_avatar_hash](#group_avatar_hash)
* [group_default_branch_protection](#group_default_branch_protection)
* [group_emails_enabled](#group_emails_enabled)
* [group_ip_restriction_ranges](#group_ip_restriction_ranges)
* [group_lfs_enabled](#group_lfs_enabled)
* [group_membership_lock](#group_membership_lock)
* [group_mentions_disabled](#group_mentions_disabled)
* [group_permanently_remove_on_delete](#group_permanently_remove_on_delete)
* [group_prevent_forking_outside_group](#group_prevent_forking_outside_group)
* [group_project_creation_level](#group_project_creation_level)
* [group_request_access_enabled](#group_request_access_enabled)
* [group_require_two_factor_authentication](#group_require_two_factor_authentication)
* [group_share_with_group_lock](#group_share_with_group_lock)
* [group_shared_runners_setting](#group_shared_runners_setting)
* [group_subgroup_creation_level](#group_subgroup_creation_level)
* [group_two_factor_grace_period](#group_two_factor_grace_period)
* [group_visibility_level](#group_visibility_level)
* [group_wiki_access_level](#group_wiki_access_level)
* [group_push_rules](#group_push_rules)
* [group_labels](#group_labels)
* [group_variables](#group_variables)
* [group_access_tokens](#group_access_tokens)


##### `group_description`

Group description
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

##### `group_parent_id`

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

##### `group_auto_devops_enabled`

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

##### `group_avatar`

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

##### `group_avatar_hash`

The hash of the avatar image. Use filesha256('path/to/avatar.png')
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

##### `group_default_branch_protection`

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

##### `group_emails_enabled`

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

##### `group_ip_restriction_ranges`

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

##### `group_lfs_enabled`

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

##### `group_membership_lock`

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

##### `group_mentions_disabled`

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

##### `group_permanently_remove_on_delete`

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

##### `group_prevent_forking_outside_group`

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

##### `group_project_creation_level`

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

##### `group_request_access_enabled`

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

##### `group_require_two_factor_authentication`

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

##### `group_share_with_group_lock`

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

##### `group_shared_runners_setting`

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

##### `group_subgroup_creation_level`

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

##### `group_two_factor_grace_period`

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

##### `group_visibility_level`

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

##### `group_wiki_access_level`

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

##### `group_push_rules`

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

##### `group_labels`

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

##### `group_variables`

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

##### `group_access_tokens`

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
<!-- markdownlint-restore -->

### Outputs

* `group_id`:
  The generated group ID
* `group_name`:
  The group name

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
