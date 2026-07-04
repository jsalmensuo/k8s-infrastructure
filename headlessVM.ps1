# Quick helpers for starting/stopping the k8s lab VMs in VirtualBox.
# Dot-source this file (or paste into your $PROFILE) to get vbk8s-start,
# vbk8s-stop and vbk8s-status as commands in any PowerShell window.

$vms = "k8s-master1","k8s-master2","k8s-master3",
       "k8s-worker1","k8s-worker2","k8s-worker3",
       "k8s-worker4","k8s-worker5","k8s-worker6"

function vbk8s-stop {
    $vms | ForEach-Object {
        & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm $_ acpipowerbutton
    }
}

function vbk8s-start {
    $vms | ForEach-Object {
        & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm $_ --type headless
        Start-Sleep -Seconds 10
    }
}

function vbk8s-status {
    $running = & "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list runningvms
    $vms | ForEach-Object {
        if ($running -match $_) {
            Write-Host "$_ - running"
        } else {
            Write-Host "$_ - stopped"
        }
    }
}