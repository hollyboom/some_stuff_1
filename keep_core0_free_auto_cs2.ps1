# =========================================
# Anaia AI– CS2 Core 0 Protection (SAFE) Xeon E3 1230 V3 Only9
# =========================================

$LogicalCores = (Get-CimInstance Win32_Processor).NumberOfLogicalProcessors

# excludem thread 0 si 1 (core 0 + HT)
$AffinityMask = 0
for ($i = 2; $i -lt $LogicalCores; $i++) {
    $AffinityMask = $AffinityMask -bor (1 -shl $i)
}

Write-Host "Detected Logical Cores: $LogicalCores"
Write-Host "CS2 Affinity Mask: 0x$("{0:X}" -f $AffinityMask)"

while ($true) {

    $p = Get-Process cs2 -ErrorAction SilentlyContinue
    if ($p) {
        try {
            $p.ProcessorAffinity = $AffinityMask
        } catch {}
    }

    Start-Sleep -Milliseconds 500
}
