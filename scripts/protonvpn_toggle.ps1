Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Threading;

public class ProtonTray {
    [DllImport("user32.dll")] public static extern IntPtr FindWindow(string cls, string win);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int n);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd, out RECT r);
    [DllImport("user32.dll")] public static extern bool MoveWindow(IntPtr hWnd, int x, int y, int w, int h, bool rp);
    [DllImport("user32.dll")] public static extern int GetSystemMetrics(int n);

    [StructLayout(LayoutKind.Sequential)] public struct RECT { public int L, T, R, B; }

    public static void Toggle(IntPtr popup, string exePath, int targetX, int targetY) {
        if (popup == IntPtr.Zero) {
            System.Diagnostics.Process.Start(exePath);
            return;
        }

        if (IsWindowVisible(popup)) {
            ShowWindow(popup, 0);
            return;
        }

        RECT r;
        GetWindowRect(popup, out r);
        int w = r.R - r.L;
        int h = r.B - r.T;

        ShowWindow(popup, 5);

        // Background thread: keep correcting position while visible
        Thread t = new Thread(() => {
            DateTime deadline = DateTime.Now.AddSeconds(5);
            while (DateTime.Now < deadline && IsWindowVisible(popup)) {
                RECT cur;
                GetWindowRect(popup, out cur);
                if (cur.L != targetX || cur.T != targetY) {
                    MoveWindow(popup, targetX, targetY, w, h, true);
                }
                Thread.Sleep(16);
            }
        });
        t.IsBackground = true;
        t.Start();

        SetForegroundWindow(popup);
    }
}
"@

$popup   = [ProtonTray]::FindWindow("WinUIDesktopWin32WindowClass", "Proton VPN (tray)")
$rect    = New-Object ProtonTray+RECT
[ProtonTray]::GetWindowRect($popup, [ref]$rect)
$w       = $rect.R - $rect.L
$screenW = [ProtonTray]::GetSystemMetrics(0)
$x       = $screenW - $w - 5
$y       = 35

[ProtonTray]::Toggle($popup, "C:\Program Files\Proton\VPN\v4.3.12\ProtonVPN.Client.exe", $x, $y)

# Keep script alive while popup is visible so the background thread keeps running
while ([ProtonTray]::IsWindowVisible($popup)) {
    Start-Sleep -Milliseconds 100
}
