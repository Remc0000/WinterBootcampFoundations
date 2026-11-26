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
Login to copilot:
```copilot
/login
```

Install all is needed for the the Winter Bootcamps:
```copilot
execute https://raw.githubusercontent.com/Remc0000/WinterBootcampFoundations/refs/heads/main/copilot%20prompt.txt
```

