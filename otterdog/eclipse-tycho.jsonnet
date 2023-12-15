local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-tycho') {
  settings+: {
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "",
    members_can_change_project_visibility: false,
    members_can_change_repo_visibility: false,
    members_can_delete_repositories: false,
    name: "Eclipse Tycho™",
    packages_containers_internal: false,
    packages_containers_public: false,
    readers_can_create_discussions: true,
    web_commit_signoff_required: false,
    workflows+: {
      default_workflow_permissions: "write",
    },
  },
  _repositories+:: [
    orgs.newRepo('eclipse-tycho.github.io') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      secret_scanning: "enabled",
      secret_scanning_push_protection: "enabled",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main",
            "master"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('tycho') {
      allow_merge_commit: true,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Tycho project repository (tycho)",
      has_discussions: true,
      homepage: "",
      secret_scanning: "enabled",
      secret_scanning_push_protection: "enabled",
      topics+: [
        "build-tool",
        "eclipse",
        "java"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('GIST_TOKEN') {
          value: "********",
        },
        orgs.newRepoSecret('TYCHO_GITLAB_API_TOKEN') {
          value: "********",
        },
        orgs.newRepoSecret('TYCHO_SITE_PAT') {
          value: "********",
        },
      ],
    },
  ],
}
