# Set environment variables for GitHub and Azure DevOps personal access tokens
$env:GH_PAT=
$env:ADO_PAT=

# Optional: Set the base API URL for GitHub Enterprise Cloud if needed
$env:TARGET_API_URL="https://api.octocorp.ghe.com"

# Define migration parameters
$GITHUB_ORG="Delware-test"
$ADO_ORG="DevOpsDreamscape"
$ACTOR="ManuCoppens"
$ACTOR_TYPE="USER"
#$ADO_TEAM_PROJECT="Stage - Manu"
#$ADO_REPO="manu.inf.repo"
#$GITHUB_REPO="test-repo"
$SCRIPT_OUTPUT="migration_script.ps1"

# Grant migrator role to the user
Write-Output "Granting migrator role to $ACTOR..."
gh ado2gh grant-migrator-role --github-org $GITHUB_ORG --actor $ACTOR --actor-type $ACTOR_TYPE

# Generate migration script
Write-Output "Generating migration script..."
gh ado2gh generate-script --ado-org $ADO_ORG --github-org $GITHUB_ORG --output $SCRIPT_OUTPUT

# Run the generated migration script
Write-Output "Running migration script..."
PowerShell -ExecutionPolicy Bypass -File $SCRIPT_OUTPUT

# Migrate a single repository
#Write-Output "Migrating repository $ADO_REPO to GitHub..."
#gh ado2gh migrate-repo --ado-org $ADO_ORG --ado-team-project "$ADO_TEAM_PROJECT" --ado-repo "$ADO_REPO" --github-org "$GITHUB_ORG" --github-repo "$GITHUB_REPO"

Write-Output "Migration process completed."
