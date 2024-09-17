locals {
  access_levels = [
    "minimal",
    "guest",
    "reporter",
    "developer",
    "maintainer",
    "owner",
  ]
  # First remove user whose privileged access have reach expiricy
  perm_not_expired = { for access_level in local.access_levels : access_level =>
    toset(compact([
      for key, val in var.membership[access_level] : val.expires_at == null ?
      key
      : (
        timecmp("${val.expires_at}T00:00:00Z", plantimestamp()) != -1 ?
        key
        : ""
      )
    ]))
  }
  # Second, assign highest privilieged if member is present in multiple access
  # level
  perm = {
    minimal = setsubtract(
      local.perm_not_expired.minimal, setunion(
        local.perm_not_expired.guest,
        local.perm_not_expired.reporter,
        local.perm_not_expired.developer,
        local.perm_not_expired.maintainer,
        local.perm_not_expired.owner,
      )
    )
    guest = setsubtract(
      local.perm_not_expired.guest, setunion(
        local.perm_not_expired.reporter,
        local.perm_not_expired.developer,
        local.perm_not_expired.maintainer,
        local.perm_not_expired.owner,
      )
    )
    reporter = setsubtract(
      local.perm_not_expired.reporter, setunion(
        local.perm_not_expired.developer,
        local.perm_not_expired.maintainer,
        local.perm_not_expired.owner,
      )
    )
    developer = setsubtract(
      local.perm_not_expired.developer, setunion(
        local.perm_not_expired.maintainer,
        local.perm_not_expired.owner,
      )
    )
    maintainer = setsubtract(
      local.perm_not_expired.maintainer,
      local.perm_not_expired.owner,
    )
  }
  # Convert to map for the resource
  membership = {
    for user, perm in transpose(local.perm) : user => one(perm)
  }
}
