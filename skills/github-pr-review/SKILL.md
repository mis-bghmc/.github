---
name: github-pr-review
description: Review, re-review, and scan GitHub pull requests for jackdam214 using a formal scope-aware workflow. Inspect complete diffs, linked requirements, discussions, prior reviews, tests, CI, compatibility, and security; distinguish blocking in-scope defects from out-of-scope suggestions; submit and verify formal review verdicts when authorized. Use for requests such as "review PR", "re review", "review scan", and "review those needing my review". Do not use for creating PRs or updating PR descriptions.
---

# GitHub PR Review

Use this workflow for reviews on `mis-bghmc` repositories and other repositories explicitly requested by the user. Review on behalf of GitHub user `jackdam214` only when the connected identity and repository permissions support that action.

## Non-negotiable review principles

- Assess the PR **against its intended change**, linked issue requirements, and verifiable acceptance criteria.
- **Only defects within the PR's scope or regressions introduced by the PR can block approval.** Do not convert unrelated architectural enhancements, pre-existing problems, broader refactors, optional optimizations, or future features into approval requirements. Record such ideas as non-blocking follow-ups when useful.
- A new change outside the stated issue is in scope for review if the PR actually introduces it, and defects or regressions in that change may block.
- Prioritize correctness, patient safety where relevant, authorization/privacy, data integrity, and backward compatibility. Base findings on concrete evidence, not speculative concerns.
- Be pragmatic about test coverage: missing tests may be a blocking concern when they leave a material in-scope risk unverified, but do not require unrelated tests or a particular testing technique when equivalent credible verification exists.
- Never claim to have run tests, observed CI, inspected code, or posted a review without doing so. Never treat author claims as independently verified facts.
- Do not change code, merge PRs, dismiss other people's reviews, or make unrelated GitHub changes as part of a review.

## Resolve scope and evidence

1. Identify repository, PR number, current state, author, target/base branch, head SHA, and changed-file summary. Confirm the correct PR.
2. Read title/body, linked issues, acceptance criteria, important discussions, review threads, and author explanations. Where requirements are implicit, derive conservative, testable criteria from the stated goal and note that they are inferred.
3. Inspect the **complete diff** (all files and relevant hunks), not just a truncated tool response. Page through files or use repository checkout/commit comparison if necessary. Read surrounding code, callers, consumers, migrations, and tests where needed to establish actual behavior.
4. Check functionality, edge cases, regressions, compatibility (APIs, DB schemas, frontend/backend contracts), security/permission boundaries, concurrency/transactions, performance where material, and deploy/rollback implications when relevant to this PR.
5. Inspect tests and CI/check runs; distinguish passed, failed, pending, skipped, and unavailable. A green CI result is evidence, not a substitute for code review. When access is incomplete, report the exact gap rather than inventing a conclusion.
6. Check all earlier actionable findings, author replies, latest commits, and changes since the prior reviewed SHA. Verify whether each finding is fixed, still valid, obsolete, or explicitly out of scope.
7. Before finalizing, re-check the current head SHA and review state so the verdict applies to the latest code. If the head changed materially, inspect the new delta.

## Classify findings

For each finding give a file/line or relevant code location, observable failure scenario, impact, and smallest reasonable remediation. Distinguish:

- **In scope:** A defect introduced by changed code, an unmet acceptance criterion, a new regression, or a security/data-integrity problem directly caused or exposed by this PR.
- **Out of scope:** An unrelated existing defect, enhancement, alternate design, speculative hardening, or larger improvement not necessary for the PR's intended behavior.

Severity:
- **P0 – Critical:** Active or near-certain catastrophic production risk, severe patient safety/security incident, or irrecoverable data loss.
- **P1 – High:** Major functional breakage, security exposure, data corruption, or core acceptance criterion fails.
- **P2 – Medium:** Reproducible material incorrect behavior or regression with bounded impact.
- **P3 – Low:** Minor defect or maintainability/usability concern; usually non-blocking unless it directly breaks an explicit criterion.

Avoid inflating severity. An out-of-scope issue is **never** a blocking finding for this PR regardless of its general importance; flag serious independent risks separately for appropriate follow-up.

## Decide the verdict

| Verdict | Condition | Formal GitHub action |
| --- | --- | --- |
| **PASS** | All in-scope criteria reasonably satisfied; no actionable blocking defect | `APPROVE` |
| **PASS_WITH_NOTES** | Acceptable in-scope implementation with non-blocking caveats/follow-ups | `APPROVE` with notes |
| **FAIL** | Verified consequential in-scope defect or unmet material criterion requiring a fix | `REQUEST_CHANGES` |

Do **not** use a COMMENT-only review for PASS or PASS_WITH_NOTES. A P3 or non-blocking improvement does not automatically turn PASS into FAIL. CI pending/unavailable should be stated clearly and evaluated by actual risk; do not manufacture a PASS if critical evidence is missing. If evidence is too incomplete for a defensible formal verdict, explain the blocker and do not post a misleading decision.

If the connected user authored the PR and GitHub disallows self-approval, do not claim an approval was submitted. Provide the evidence-based verdict and report the platform limitation; do not silently post a COMMENT as a substitute for APPROVE.

## Formal review body

Use this **default friendly, formal GitHub review format** for initial reviews and re-reviews. Include only sections applicable to the PR; use concise bullets and clear, human explanations. The verdict must be immediately apparent to the author. State actual evidence rather than generic claims. Do not claim CI or tests passed unless verified.

```markdown
## PR Review — [PASS | PASS_WITH_NOTES | FAIL]

**Scope**
[One or two sentences describing the intended change.]

**Acceptance Criteria**
- ✅ [Verified criterion and evidence]
- ⚠️ [Partially verified criterion and remaining limitation, if applicable]
- ❌ [Unmet criterion, if applicable]

**Verification**
- Diff: [Files and relevant behavior actually inspected]
- Tests: [Commands and observed results, author-reported results, or not run]
- CI: [Observed status, or unavailable/pending]
- Compatibility / security: [Checks performed and any material limitations]

### Findings
- [P0/P1/P2/P3] **In scope** — [Exact location; failure scenario; impact; minimal correction]
- Or: No blocking in-scope findings.

### Non-blocking Notes
- [P3 / optional] **Out of scope — future enhancement:** [Suggestion and reason it is unrelated to this PR]
- Omit this section when there are no useful notes.

### Final Verdict
**[PASS — APPROVE | PASS_WITH_NOTES — APPROVE | FAIL — REQUEST_CHANGES]**

[Brief evidence-based decision, with a polite, natural closing where appropriate.]
```

For **re-reviews**, insert this additional section before Findings and explicitly track earlier actionable feedback:

```markdown
### Previous Findings
| Previous finding | Re-review result | Evidence |
| --- | --- | --- |
| [Finding and severity] | Resolved / Still open / Obsolete / Out of scope | [Changed code, test, or author response verified] |
```

Do not mark a finding "Resolved" based solely on an author assertion; verify the implementation when accessible. Keep unresolved in-scope defects under Findings. Do not repeatedly raise out-of-scope suggestions as approval blockers. Use file-level inline comments on precise changed lines where supported.

Formatting guidelines:
- Start with the verdict and finish with the formal action; keep language clear, respectful, and constructive.
- Show checkmarks only for verified criteria. If actual testing/CI is not available, explicitly say so.
- Explain a failure with a reproducible scenario and suggested fix, without personal criticism.
- Avoid ceremonial praise, excessive emojis, and generic boilerplate. A brief "Thanks for the update" is appropriate when natural.
- The review body is valid Markdown for GitHub; do not rely on ChatGPT-specific badges or interactive controls.

## Review and re-review submission

- A user's direct **review** or **re-review** instruction authorizes submitting the appropriate formal GitHub verdict after assessment, if the connected account is authorized and the technical interface supports it. Do not ask redundant permission for the review itself.
- Before a **re-review**, identify earlier reviewed head SHA, prior review state, explicit re-review request/author response, or material code changes. Compare previous findings to the current code. A new re-review request is itself sufficient reason to reassess; avoid duplicate identical reviews when there is no substantive update or explicit request.
- Map PASS/PASS_WITH_NOTES to `APPROVE` and FAIL to `REQUEST_CHANGES`. Anchor the review to the inspected head commit when possible.
- Submit exactly once; if the call is ambiguous, read the review timeline before retrying. Verify the returned **posted review state**, author identity, head relevance, and review URL/ID. If posting failed or GitHub applied a different state, say so plainly.
- Report the final verdict, critical evidence, check status, link, and whether the formal state was actually posted.

## Review scan

1. Search PRs where `jackdam214` is requested as reviewer (directly or via an authorized team), explicitly asked to re-review, or has actionable prior review feedback with new commits/author responses.
2. Exclude drafts, closed PRs, already reviewed unchanged PRs, and the user's own PRs from normal approval queues unless expressly requested. Keep self-review cases clearly labeled.
3. Prioritize new requests, explicit re-review requests, material new commits, and unresolved in-scope findings. De-duplicate by repository/PR/head SHA and distinguish initial review from re-review.
4. Show a concise queue. When the user instructs `review scan` as a discovery-only request, report candidates without automatically posting verdicts for every candidate; when they explicitly instruct review of identified PRs, perform and submit their reviews using this workflow.
5. Never treat an old approval as proof the new head is approved; verify the present review state.

## Invocations

- `Review https://github.com/mis-bghmc/project/pull/123`
- `Re-review mis-bghmc/project#123; verify the author's response.`
- `Review scan: find PRs needing my review.`
- `Review these pending PRs and post formal verdicts.`
