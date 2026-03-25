import subprocess

subprocess.Popen(
    ["explorer.exe", "ms-screenclip:"],
    creationflags=subprocess.CREATE_NO_WINDOW
)
