---
name: gh-pr-preview-submit
description: Prepare, preview, and publish GitHub pull requests or update existing PR titles and descriptions using the user's checklist template. Ground descriptions in the branch diff and acceptance criteria in linked issues, and require approval of the complete preview before writing to GitHub. Use for PR creation and description updates, not code review or standalone commit-and-push requests.
---

# GitHub PR Preview and Submit

Create or update a PR using [assets/pr-template.md](assets/pr-template.md). Preserve its headings, emoji labels, and checklist options. Also support preview-only requests.

## Resolve the PR and branches

- Identify the repository and source (head) branch from the request and repository context. Resolve an explicitly supplied PR number or URL; otherwise check for an existing open PR for the source branch before proposing creation. Ask when multiple repositories or PRs fit.
- Perform the existing-PR lookup before asking the user whether the action is to create or update. If exactly one open PR matches the resolved repository and source branch, infer an update and use that PR. If none matches, infer a new-PR creation. Ask the user to choose only when multiple matching PRs exist, the requested operation conflicts with the lookup, or the repository/source cannot be resolved. If the GitHub lookup fails, disclose the failure and do not infer that no PR exists.
- When the skill is invoked without an explicit create/update operation, use the lookup result to determine the action: update the single matching PR or prepare a new PR when no matching PR exists. The user must still specify the target branch when it is not provided, and must provide or confirm the issue source required below.
- If the user has not specified the target (base) branch in this task, ask which branch to merge into. An existing PR's base is a useful suggestion, but does not replace this question. Never silently choose the default branch. Read-only inspection may continue while awaiting the answer; the final comparison requires the selected base.
- Updating a title or body does not authorize retargeting an existing PR. Resolve a discrepancy between the selected target and existing PR base with the user before preparing a publishable update.
- Read current PR metadata and body when updating. Preserve meaningful issue links and user-authored context unless superseded by the request. Do not create a duplicate PR.

## Gather evidence

- Treat `## 🔗 Related Issue(s)` in an existing PR or supplied draft as the primary issue-link location. Follow each reference and read the issue title, body, and relevant clarifications. User-supplied issue links also apply. Resolve bare issue numbers against the correct repository and preserve cross-repository links.
- If no issue is linked, ask for the issue number or URL. Branch names and commit messages can suggest candidates but do not establish an issue relationship. If an issue is inaccessible, request its relevant contents rather than inventing requirements.
- Use the issue for the problem, intended outcomes, and acceptance criteria. Use the committed diff for what this PR actually changes. Existing PR prose and commit messages provide context but are not proof of implementation.
- Compare the selected base and head using the merge-base (three-dot) diff, such as `git diff <base-ref>...<head-ref>`, and inspect relevant files. Verify repository identity and resolve current refs before relying on the comparison. A GitHub PR diff is suitable when its base and head match the selected branches. Record the compared commit IDs for the preview evidence.
- Exclude uncommitted changes from claims about the PR. Distinguish local commits from the published head. Disclose any required commit or push; do not silently stage, commit, or push as part of a description update.

## Write the title and body

- Use a concise title describing the concrete change. Lead Description with the problem and resulting behavior, followed by material changes supported by the diff. Explain deviations from issue scope instead of claiming all requested behavior is implemented.
- Replace the template's `# 📌 [Pull Request Title]` placeholder with the exact proposed PR title. The title shown in the PR metadata and this first Markdown heading must match exactly.
- Use `Closes` only when the PR fully addresses an issue and closure is intended. Use `Related to` for partial or supporting work. Remove unused issue placeholders. Never publish bare `Closes #` or invented links. An explicitly issue-free PR may say no issue applies.
- Copy explicit acceptance criteria from the issue faithfully, retaining identifiers, qualifiers, and scope. Use as many items as needed; the template's three rows are not a limit. For multiple issues, label criteria with their source issue.
- If an issue has no explicit criteria, derive verifiable criteria solely from its stated requirements. Use the template's normal `AC1`, `AC2`, etc. labels, and state that the criteria require confirmation in a surrounding preview note or HTML comment rather than in the criterion labels. Ask the user to confirm those criteria before publication. Never derive criteria solely from implemented code. If the user explicitly permits an issue-free PR, ask for criteria or permission to omit them.
- Leave acceptance checkboxes unchecked unless each checked criterion has supporting verification evidence. Do not carry issue checkbox completion into the PR automatically. Explain partial or unverified criteria without deleting them to make the PR appear complete.
- Check every applicable Type of Change option based on the diff.
- Mark Testing Performed only from observed results or clearly attributed user reports applicable to this change. Record commands, outcomes, and material limitations under Details. Do not claim manual testing based on reading code. If no applicable testing is evidenced, select Not tested and explain. Running tests is not required merely to draft a PR.

## Preview, approval, and publication

1. Show the action (create or update), repository, source → target branches, existing PR URL if any, and draft/ready status for creation. Preserve an existing PR's status. Default new PRs to ready for review unless the user requests a draft; state that choice in the preview.
2. Show the exact proposed title and full Markdown body. Separately summarize compared commits, issue sources, unresolved information, and publication prerequisites. Resolve missing target branches, inaccessible requirements, and unconfirmed criteria before treating the result as ready to publish.
3. Ask: **“Do you want me to post this PR?”** or **“Do you want me to update this PR with this title and description?”** The user requires approval after reviewing the concrete preview. An initial create/update request is not approval of an unseen body. Explain that this preview-first requirement comes from this skill and link this SKILL.md when asking. A preview-only request stops with the preview.
4. Once the user approves that preview, publish without redundant confirmation. If the title, body, branches, or draft status materially change, show the revised preview and obtain approval for it. Recheck the head, base, issue requirements, and existing PR body before writing; refresh a stale preview instead of overwriting intervening changes.
5. Use an available GitHub connector or `gh`. With `gh`, save the approved body to a UTF-8 file and use `--body-file`; preserve actual line breaks. Specify the repository and branches explicitly on creation. On update, change only the approved title/body. Do not merge the PR or post additional comments as part of this workflow.
6. If a write fails or its result is ambiguous, inspect GitHub state before retrying to prevent duplicate PRs. Report a persistent blocker rather than repeatedly submitting. Verify the resulting title/body and return the PR link with a concise result.

## Invocation examples

```text
$gh-pr-preview-submit Prepare a PR from my current branch into develop for issue #123. Preview first.

$gh-pr-preview-submit Update PR #456's title and description against develop using its linked issues. Preview before posting.

$gh-pr-preview-submit Preview only: prepare the current branch's PR into main for issue #123.
```
