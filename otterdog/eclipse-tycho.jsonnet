local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-tycho') {
  settings+: {
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "",
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
      allow_auto_merge: true,
      allow_merge_commit: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Tycho project repository (tycho)",
      has_discussions: true,
      homepage: "https://tycho.eclipseprojects.io",
      secret_scanning: "enabled",
      secret_scanning_push_protection: "enabled",
      topics+: [
        "build-tool",
        "eclipse",
        "java",
        "maven",
        "OSGi"
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
      rulesets: [
        orgs.newRepoRuleset('main') {
          allows_updates: true,
          bypass_actors+: [
            "@eclipse-tycho/technology-tycho-committers"
          ],
          include_refs+: [
            "refs/heads/main",
          ],
          required_approving_review_count: 0,
          required_status_checks+: [
            "continuous-integration/jenkins/pr-head",
            "call-license-check / check-licenses"
          ],
          requires_commit_signatures: false,
          requires_last_push_approval: false,
          requires_review_thread_resolution: false,
        },
      ],
    },
  ],
}
