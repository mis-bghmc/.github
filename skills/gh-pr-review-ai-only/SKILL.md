# GitHub PR Review — AI Only

Use this file as the authoritative review policy for automated PR reviews in the `mis-bghmc` organization.

## Scope

Review the actual pull request changes, not just the PR description. Inspect the PR metadata, base/head SHAs, commit history, full diff/patch, changed files, prior review submissions, review threads, top-level discussion, CI/check status when available, and any linked issue/context needed to understand the change.

For re-reviews, compare the current head against the state reviewed previously. Focus on whether previously raised findings were addressed, whether the fixes introduced regressions, and whether new commits changed the review surface.

## Duplicate-review guard

Before posting a review, identify the author's latest explicit review/re-review request or the latest reviewer assignment that requires action. If `jackdam214` already submitted a review, review comment, or equivalent response after that trigger, do not post another review unless there is a newer author request or materially newer code that clearly requires another review.

Do not re-process an unchanged head SHA after a completed review unless the author explicitly requests another review and there is meaningful new context requiring a response.

## Review priorities

Evaluate correctness, security, data integrity, authorization, validation, error handling, transactionality, concurrency/idempotency where relevant, backwards compatibility, maintainability, performance, and test coverage. In hospital/clinical systems, give extra attention to patient-data correctness, access control, workflow enforcement, auditability, and fail-closed behavior.

Only report actionable findings supported by the changed code or directly relevant surrounding code. Do not invent defects. Distinguish blockers from non-blocking notes.

Severity:
- P0: catastrophic safety/security/data-loss issue requiring immediate stop.
- P1: critical correctness/security issue; merge must be blocked.
- P2: significant bug/regression or important missing safeguard; normally block merge.
- P3: non-blocking maintainability, clarity, test, UX, or minor correctness note.

## Verdict

Use exactly one verdict:
- `PASS` — no actionable findings.
- `PASS_WITH_NOTES` — only non-blocking notes remain.
- `FAIL` — one or more blocking findings remain.

Map verdict to GitHub review action:
- PASS = APPROVE
- PASS_WITH_NOTES = COMMENT
- FAIL = REQUEST_CHANGES

## Review body format

Use this format for the posted review:

# ✅ APPROVED
or
# ✅ APPROVED — with notes
or
# ❌ CHANGES REQUESTED

**PR** [**#<number>**](<pr-url>) — <short summary including finding counts>

## Severity Summary

- VERDICT: <PASS|PASS_WITH_NOTES|FAIL>
- P0: <count>
- P1: <count>
- P2: <count>
- P3: <count>
- Criteria met: <met>/<total>

> base `<base>@<short-sha>` · head `<head>@<short-sha>` · reviewed range `<base-short>..<head-short>`

## Findings

For each finding include severity, affected file/area, what is wrong, why it matters, and the required or recommended correction. Keep findings concrete and concise.

If there are no findings, state that no actionable findings were identified in the reviewed range.

## Verification

Briefly state what was inspected or verified, including relevant tests/checks and any limitations. Do not claim to have run commands or tests that were not actually run.

For re-reviews, include a short section summarizing the disposition of previously raised findings and whether they are fixed, partially fixed, still open, or superseded.

## Posting rules

Do not ask for confirmation for read-only inspection. Once the review is complete, automatically post the mapped GitHub review action. Do not merge the PR. Do not modify code. Do not post duplicate reviews. If a required source cannot be inspected well enough to reach a defensible verdict, do not guess; report the blocker instead of posting an approval/request-changes verdict.
