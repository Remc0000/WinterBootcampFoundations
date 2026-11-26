## 🚀 Quick setup

Open **Windows PowerShell** and paste the following command:

```powershell
mkdir C:\WinterBootcamp -Force; cd C:\WinterBootcamp; irm "https://raw.githubusercontent.com/Remc0000/WinterBootcampFoundations/refs/heads/main/installCopilot.ps1" -OutFile ".\installCopilot.ps1"; powershell.exe -ExecutionPolicy Bypass -File ".\installCopilot.ps1"
```

The installer will:

- Check/install PowerShell 7
- Install/update Node.js 24 LTS
- Install/update GitHub Copilot CLI
- Open GitHub Copilot CLI
- Use `C:\WinterBootcamp` as the working directory


## Open copilot
type:
```copilot
/login
```

```copilot
execute https://github.com/Remc0000/WinterBootcampFoundations/edit/main/README.md
```

