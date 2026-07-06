# Quick helpers for starting/stopping the k8s lab VMs in VirtualBox.
$all_vms = "k8s-master1","k8s-master2","k8s-master3",
           "k8s-worker1","k8s-worker2","k8s-worker3",
           "k8s-worker4","k8s-worker5","k8s-worker6"

function vbk8s-stop {
    param([string[]]$target = $all_vms)
    $target | ForEach-Object {
        Write-Host "Stopping $_..." -ForegroundColor Yellow
        & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm $_ acpipowerbutton
    }
}

function vbk8s-start {
    param([string[]]$target = $all_vms)
    $target | ForEach-Object {
        Write-Host "Starting $_..." -ForegroundColor Green
        & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm $_ --type headless
        Start-Sleep -Seconds 10
    }
}

function vbk8s-status {
    param([string[]]$target = $all_vms)
    $running = & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list runningvms
    $target | ForEach-Object {
        if ($running -match $_) {
            Write-Host "$_ - running" -ForegroundColor Cyan
        } else {
            Write-Host "$_ - stopped" -ForegroundColor Gray
        }
    }
}