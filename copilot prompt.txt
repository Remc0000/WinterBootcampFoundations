Turn YOLO on!

Prepare this machine for working with Microsoft Fabric, Skills for Fabric, Rayfin, Azure, GitHub Copilot and MCP servers.

Work through the steps below in order.

IMPORTANT:
- First check what is already installed.
- Check the currently installed version and whether an update is needed.
- Do not reinstall tools that are already correctly installed and up to date.
- If something is missing, install it.
- After installation or update, verify that the tool works.
- Use official Microsoft or GitHub documentation where possible.
- Do not assume that an installation, update, authentication or configuration succeeded. Verify it.

## 1. Check prerequisites

Check whether the following are installed and up to date:

### Git
Check that Git is installed and working.

### Node.js and npm
Check that Node.js and npm are installed and up to date.

Node.js is required by several of the tools used below, including Rayfin and Microsoft Foundry tooling.

Verify:
- node
- npm
- npx

### Python
Check whether Python 3.13 is installed.

If Python 3.13 is not installed, install it.

Create a Python 3.13 virtual environment for Fabric-related Python tooling.

- Prefer installing Python packages into this virtual environment rather than globally.
- Verify that Python and pip are working from the virtual environment.
- Do not replace another working Python installation unnecessarily.

### Azure CLI
Check whether Azure CLI is installed and whether it needs an update.

Documentation:
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

Verify that the CLI works after installation or update.

### GitHub CLI
Check whether GitHub CLI is installed and whether it needs an update.

Documentation:
https://github.com/cli/cli

Verify that the CLI works after installation or update.

### Rayfin CLI
Check whether Rayfin CLI is available and whether it needs an update.

Documentation:
https://learn.microsoft.com/en-us/fabric/apps/cli-reference

Use the current installation guidance from the documentation.

Verify that Rayfin works after installation or update.


## 2. Authentication

When the required CLI tools are installed, verify authentication.

### Azure CLI
Check whether I am logged in.

If needed, authenticate using the appropriate Azure CLI login flow.

Verify the authenticated account and active Azure subscription.

### Fabric CLI
Check whether I am logged in with the Fabric CLI used by the installed Fabric tooling.

If needed, authenticate.

Verify that authentication succeeded.

### GitHub CLI
Check whether I am authenticated with GitHub CLI.

If needed, authenticate.

Verify that authentication succeeded.

Do not assume authentication succeeded just because a login command completed.


## 3. Install or update AI skills

Check whether the following skills are already installed and up to date.

Install or update them when necessary.

Do not maintain duplicate copies of the same skills if an existing installation can simply be updated.


### Azure Skills

https://github.com/microsoft/azure-skills


### Skills for Fabric

https://github.com/microsoft/skills-for-fabric


### Rayfin / Fabric Apps Skills

https://github.com/microsoft/rayfin/blob/main/skills/rayfin-getting-started/SKILL.md

Use the Rayfin CLI and documentation to determine the current recommended way to install or update the Rayfin agent files and skills.


### Microsoft Foundry Skills

Documentation:
https://learn.microsoft.com/en-us/azure/foundry/how-to/develop/use-microsoft-foundry-skill?tabs=copilot-cli

Check whether the Microsoft Foundry Skill is already available.

Install or update it when necessary using the current recommended installation method from the documentation.

Be aware that some Azure/Foundry skill installation methods may also configure Azure MCP and Foundry MCP servers. Do not create duplicate MCP configurations.


## 4. Configure MCP servers

Check whether the following MCP servers are already configured and working.

Do not create duplicate MCP server configurations.


### Microsoft Learn MCP Server

Documentation:
https://learn.microsoft.com/en-us/training/support/mcp

Check whether the Microsoft Learn MCP Server is already configured.

If it is missing, configure it using the current Microsoft documentation.

Verify that the MCP server can actually be discovered and used by the coding agent.


### GitHub MCP Server

https://github.com/github/github-mcp-server

Check whether the GitHub MCP Server is already configured.

If it is missing, configure it using the current GitHub documentation.

Verify that it can actually be discovered and used by the coding agent.


### Azure / Foundry MCP servers

Check whether installation of the Azure Skills or Microsoft Foundry Skill already configured Azure MCP and/or Foundry MCP servers.

If they are already configured and working, do not configure them again.

Verify that the available MCP servers can actually be discovered and used.


## 5. Final validation

When everything is complete, perform a final validation.

Give me a compact status report containing:

- Tool/component
- Installed version where applicable
- Updated: yes/no
- Authentication status where applicable
- Skills installed and/or updated
- MCP servers configured
- MCP servers successfully discovered
- Any remaining actions, warnings or problems

Specifically verify:

- Git works
- Node.js works
- npm works
- npx works
- Python 3.13 works
- The Python virtual environment works
- Azure CLI works
- Azure CLI authentication works
- GitHub CLI works
- GitHub authentication works
- Fabric CLI authentication works
- Rayfin works
- Azure Skills are available
- Skills for Fabric are available
- Rayfin/Fabric Apps skills are available
- Microsoft Foundry Skill is available
- Microsoft Learn MCP is available
- GitHub MCP is available
- Azure/Foundry MCP servers are available if installed

Do not just tell me which commands I should run.

Perform the checks, installation, updates and configuration where possible, then verify the result.


## Fabric Apps rule

Whenever I ask you to create, modify or troubleshoot a Microsoft Fabric app:

1. Use the installed Rayfin / Fabric Apps skills.

2. Always check the Rayfin repository for the latest guidance, examples, supported patterns and capabilities:

https://github.com/microsoft/rayfin

3. Also use the current Rayfin CLI documentation:

https://learn.microsoft.com/en-us/fabric/apps/cli-reference

4. Prefer current Rayfin patterns, skills and documentation over assumptions or outdated examples.

5. Before implementing something yourself, check whether Rayfin already provides the required functionality or recommended pattern.