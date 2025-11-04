# 🔒 Windows Firewall Blocker Script (Fully Explained)

This project contains two simple and transparent `.bat` (Batch) scripts that let you **block or unblock internet access** for all `.exe` files in a folder and its subfolders.

```
D:\Folder
│
├── 📁 Folder1
│   ├── play.exe        ← 🚫 Blocked (inbound + outbound)
│   ├── updater.exe     ← 🚫 Blocked (inbound + outbound)
│   └── data\
│       └── helper.exe  ← 🚫 Blocked (inbound + outbound)
│
├── 📁 Folder2
│   ├── launcher.exe    ← 🚫 Blocked (inbound + outbound)
│   ├── config.exe      ← 🚫 Blocked (inbound + outbound)
│   └── readme.txt      (ignored — not an .exe)
│
└── 📁 Tools
    ├── patcher.exe     ← 🚫 Blocked (inbound + outbound)
    └── cleanup.bat     (ignored — not an .exe)
```

They are 100% offline, safe, and reversible — they only interact with **Windows Firewall** using official system commands.

---

## 📦 Files Included

| File | Description |
|------|--------------|
| `Firewall_Blocker.bat` | Main script — blocks `.exe` files from internet access. |
| `Unblock_All.bat` | Cleanup script — removes all "Blocked:" rules. |
| `README.md` | This explanation file. |

---

## 🧰 1. Firewall_Blocker.bat [[Fluffy_WAR_Bunny](https://www.reddit.com/user/Fluffy_WAR_Bunny/)]

```bat
@ setlocal enableextensions
REM Enables command extensions (advanced batch features). Ensures modern for loop behavior.

@ cd /d "%~dp0"
REM Switches the working directory to the folder where this script is saved. /d allows drive changes (e.g., from C: to D:). This ensures the script only affects files in its own folder and subfolders.

for /R %%f in (*.exe) do (
REM Loops through all .exe files in the current directory and all subfolders recursively. %%f holds each file’s full path.

netsh advfirewall firewall add rule name="Blocked: %%f" dir=out program="%%f" action=block
REM Uses Windows’ built-in netsh command to add a firewall rule that blocks outgoing (outbound) internet traffic for each .exe file.

netsh advfirewall firewall add rule name="Blocked: %%f" dir=in program="%%f" action=block
REM Adds another firewall rule to block incoming (inbound) traffic for each .exe file.

)
REM Closes the for loop.

pause
REM Waits for the user to press any key before closing the window.
```

---

## 🧰 1. Unblock_All.bat [`By ChatGPT`]

```bat
@echo off
REM Turns off command echoing, so the commands themselves don’t print to the console.

echo Removing all "Blocked:" rules from Windows Firewall...
REM Prints a message to inform the user what the script is doing.

for /f "tokens=1,* delims=:" %%a in ('netsh advfirewall firewall show rule name^=all ^| findstr /I "Blocked:"') do (
REM Starts a loop to process each firewall rule whose name contains "Blocked:".

    netsh advfirewall firewall delete rule name="%%a:%%b"
    REM Deletes the firewall rule for the current line in the loop.

)
REM Closes the for loop.

echo.
REM Prints a blank line for readability in the console output.

echo Done! All "Blocked:" rules have been removed.
REM Prints a confirmation message that the process is complete.

pause
REM Waits for the user to press any key before closing the window.
```

---

**Author:** [Fluffy_WAR_Bunny](https://www.reddit.com/user/Fluffy_WAR_Bunny/) *(account banned 😞)*

```txt
So what you want to do (Windows) is make a blank text file. Paste these words into the text file:

@ setlocal enableextensions
@ cd /d "%~dp0"

for /R %%f in (*.exe) do (
netsh advfirewall firewall add rule name="Blocked: %%f" dir=out program="%%f" action=block
netsh advfirewall firewall add rule name="Blocked: %%f" dir=in program="%%f" action=block
)
pause

Once you have your words above pasted in the text file, save the file (I just call mine "PIRATE CUTLASS"), and I emailed it to myself so I never lose it.

Once you have your text file, we want to turn it into a .BAT file. You simply open up properties on your text file, and change the extension from .txt to .bat.

You want to copy this bat file. Then navigate to the folder of the program you want to silence. So for instance if you wanted to block all incoming and outgoing network signals for Autocad, you go to c:/programs/autodesk/autocad

Sometimes a program may install more than one folder, so pay attention by looking at your file trees listed by date, before and after installs. Occasionally a program installs another folder in a total other folder. c:/AppData is a hidden folder in Windows that often stuff gets installed in. Always have it open for an install to watch for new folders which would need their own Pirate Cutlass.

Then paste the bat file in here in the topmost level of the program but dont put it in the overarching Autodesk folder because that will also block legitimate Autodesk programs. They do seem to work okay together for me but I have had issues with (legal) Meshmixer and had to reinstall it.

So you simply paste your PIRATE CUTLASS dot BAT in the installed program folder. Then Run as Administrator. Itll pop up a Command Line screen and itll go through the folder and subfolders and block every single .EXE from incoming and outgoing traffic. It used to take me hours to do this manually with a program like Autocad which contains tons of exe files in its install folder and any one of them can phone home. You want to eradicate their communication abilities.

Theres another firewall setting you want to check before you open the program. So, also do this:

You go to control panel -> system and security -> windows defender firewall -> click "Allow an app or feature through windows defender firewall" change all autodesk files to private and uncheck public and do this before you ever open the program. I don't think Windows lets you uncheck both but if it does, uncheck both. Otherwise only keep private selected.

This might seem complicated but its very simple to do and get in the routine of. I havent had a single pirated program stop on me except that (legal) Meshmixer.
```
