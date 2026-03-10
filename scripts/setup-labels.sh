#!/bin/bash

existingLabels=(
    "bug|🐛 type/bug|d73a4a|Something isn\t working."
    "documentation|📖 type/documentation|0075ca|Improvements or additions to documentation."
    "duplicate|🔁 status/duplicate|cccccc|This issue or pull request already exists."
    "enhancement|🔧 type/enhancement|0075ca|Suitable for first-time contributors."
    "good first issue|🍀 status/good-first-issue|7057ff|Should be prioritized soon."
    "help wanted|🆘 status/help-wanted|008672|Extra attention is needed."
    "invalid|🚫 status/invalid|e4e669|Not a valid issue or incorrectly reported."
    "question|❓ type/question|d876e3|General questions or discussions."
    "wontfix|❌ status/wontfix|b60205|This will not be worked on."
)

# Loop through labels and update them
for label in "${existingLabels[@]}"; do
    IFS="|" read -r old_name new_name color desc <<< "$label"
    
    echo "Updating label: $old_name -> $new_name"
    gh label edit "$old_name" --name "$new_name" --color "$color" --description "$desc"
done


newLabels=(
    "🔥 priority/critical|ff5722|Major functionality broken."
    "⚠️ priority/high|ffa500|Needs attention soon."
    "🛠️ priority/low|cccccc|Minor impact."
    "⚖️ priority/medium|ffd700|Standard priority."
    "💡 priority/nice-to-have|d4e157|Optional or future enhancement."
    "🌀 priority/trivial|f5f5f5|Cosmetic or very low  priority."
    "🚨 priority/urgent|e60000|Needed fixed immediately."
    "🖥️ scope/backend|0033cc|Affects the backend (API, database, logic)."
    "🗄️ scope/database|795548|Affects database models, migrations, or queries."
    "📦 scope/dependencies|ff9800|Updates or changes related to dependencies."
    "⚙️ scope/devops|4caf50|Related to CI/CD, deployment, or infrastructure."
    "🎨 scope/frontend|ff66b2|Affects the frontend (UI, components)."
    "🚧 status/blocked|8b0000|Cannot proceed until another issue is resolved."
    "⏳ status/in-progress|1d76db|Currently being worked on."
    "👀 status/needs-review|ffcc00|Awaiting feedback or review."
    "🛑 status/on-hold|808080|Paused temporarily."
    "🎨 type/design|ff9f1c|Issues related to UI/UX improvements."
    "✨ type/feature|a2eeef|Improvements to an existing feature."
    "🪚 type/modification|ffb6c1|Changes to existing feature to meet requirements."
    "🏗️ type/refactor|fbca04|Code cleanup or restructuring without changing functionality."
    "📌 type/task|39cccc|Development task that need to be completed before deployment."
    "🧪 type/test|f9d0c4|Issues related to testing, coverage, or CI/CD."
    "📝 type/weekly-review|4A90E2|Review summary for a week."
    "📚 type/issue-compilation|A1EDD4|Issue collections."
)

for label in "${newLabels[@]}"; do
    IFS="|" read -r name color desc <<< "$label"
    gh label create "$name" --color "$color" --description "$desc"
done



echo "✅ GitHub labels updated successfully!"#!/bin/bash
