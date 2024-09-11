local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-tycho') {
  settings+: {
    description: "",
    name: "Eclipse Tycho™",
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
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Tycho project repository (tycho)",
      has_discussions: true,
      homepage: "https://tycho.eclipseprojects.io",
      topics+: [
        "build-tool",
        "eclipse",
        "java",
        "maven",
        "osgi"
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
          value: "pass:bots/technology.tycho/gitlab.eclipse.org/api-token",
        },
        orgs.newRepoSecret('TYCHO_SITE_PAT') {
          value: "********",
        },
      ],
      rulesets: [
        orgs.newRepoRuleset('release-branches') {
          allows_updates: true,
          bypass_actors+: [
            "#Write"
          ],
          include_refs+: [
            "refs/heads/main",
            "refs/heads/tycho-2.7.x",
            "refs/heads/tycho-3.0.x",
            "refs/heads/tycho-4.0.x"
          ],
          required_approving_review_count: 0,
          required_status_checks+: [
            "call-license-check / check-licenses",
            "continuous-integration/jenkins/pr-head"
          ],
          requires_commit_signatures: false,
          requires_last_push_approval: false,
          requires_review_thread_resolution: false,
        },
      ],
    },
  ],
}
