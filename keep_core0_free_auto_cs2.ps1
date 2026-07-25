# =========================================================================
# 1. Fortare drepturi de Administrator (UAC Auto-Elevate)
# powershell.exe -ExecutionPolicy Bypass -File "C:\Tools\keep_core0_free_auto_cs2.ps1"
# evade INTEL-SA-00289 back to CVE-2019-11157 : ) Just4fun
# Adaugare mod Volt2 0.945/0.946 pentru CPUID 0x306C3
# =========================================================================
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $arguments = (Get-WmiObject Win32_Process -Filter "ProcessID=$PID").CommandLine
    $arguments = $arguments -replace '^"[^"]+" \s*', ''
    $arguments = $arguments -replace '^[^ ]+ \s*', ''
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# =========================================================================
# 2. Aplicare optimizari MSR si Undervolt la 0.945V
# =========================================================================
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "1. Se aplica optimizarile MSR si Undervolt (0.945V)..." -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# Maximizare limite de putere (Turbo Boost nelimitat)
& "C:\Tools\msr-cmd.exe" -A write 0x610 0x0000a580 0x0000a580

# Optimizare control energie (Dezactivare throttling prematur)
& "C:\Tools\msr-cmd.exe" -A write 0x1FC 0x00000000 0x0004005f

# Fortare frecventa maxima Cache (Uncore)
& "C:\Tools\msr-cmd.exe" -A write 0x620 0x00000000 0x00001f1f

# Undervolt stabil la 0.945V utilizand registrul MSR 0x150 (Mailbox)
# & "C:\Tools\msr-cmd.exe" -A write 0x150 0x80000011 0x00000000
& "C:\Tools\msr-cmd.exe" -A write 0x150 0x80000011 0xF4A00000

# =========================================================================
# 3. 
# =========================================================================
Write-Host "`n==================================================" -ForegroundColor Green
Write-Host "2. Se lanseaza protectia Core 0 pentru CS2..." -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green

$LogicalCores = (Get-CimInstance Win32_Processor).NumberOfLogicalProcessors

#  
$AffinityMask = 0
for ($i = 2; $i -lt $LogicalCores; $i++) {
    $AffinityMask = $AffinityMask -bor (1 -shl $i)
}

Write-Host "Detectat nuclee logice: $LogicalCores"
Write-Host "Masca afinitate CS2: 0x$("{0:X}" -f $AffinityMask)"
Write-Host "--------------------------------------------------"
Write-Host "Scriptul ruleaza in bucla. Nu inchide aceasta fereastra in timp ce joci!" -ForegroundColor Yellow

$alreadyProtected = $false

while ($true) {
    $p = Get-Process cs2 -ErrorAction SilentlyContinue
    if ($p) {
        if (-not $alreadyProtected) {
            try {
                $p.ProcessorAffinity = $AffinityMask
                Write-Host "[$(Get-Date -Format 'HH:mm:ss')] CS2 a pornit! Afinitatea Core 0 Protection a fost aplicata." -ForegroundColor Cyan
                $alreadyProtected = $true
            } catch {}
        }
    } else {
        #  
        $alreadyProtected = $false
    }
    Start-Sleep -Milliseconds 500
}
