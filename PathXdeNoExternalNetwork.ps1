# Run this as administrator

$ErrorActionPreference = "Stop"

Add-Type -Path Mono.Cecil.dll


function PatchMethod($path, $type, $method, [ScriptBlock]$process){       
    $backup = $path + ".backup"
    $temp = $path + ".temp"
    
    if(Test-Path $backup){
        Write-Host "$path already patched"
        return
    }
    
    cp -force $path $temp

    $assembly = [Mono.Cecil.AssemblyDefinition]::ReadAssembly($path);
    $type = $assembly.MainModule.Types.Where({$_.FullName -eq $type})
    $method = $type.Methods.Where({$_.Name -eq $method})

    $processor = $method.Body.GetILProcessor()
    & $process
    $assembly.Write($path)
    
    mv -force $temp $backup

    Write-Host "$path patched"
} 

PatchMethod "${env:ProgramFiles(x86)}\Microsoft XDE\10.0.10240.0\Xde.exe" "Microsoft.Xde.Client.XdeController" "InitializeExternalSwitches" { 
    $firstInstruction = $processor.Body.Instructions[0]
    $processor.InsertBefore($firstInstruction, $processor.Create([Mono.Cecil.Cil.OpCodes]::Ldc_I4_1))
    $processor.InsertBefore($firstInstruction, $processor.Create([Mono.Cecil.Cil.OpCodes]::Ret))
}

PatchMethod "${env:ProgramFiles(x86)}\Microsoft XDE\10.0.10240.0\Microsoft.Xde.Wmi.dll" "Microsoft.Xde.WMI.XdeVirtualMachineSettings" "DeletePortSettingData" { 
    $firstInstruction = $processor.Body.Instructions[0]
    $processor.InsertBefore($firstInstruction, $processor.Create([Mono.Cecil.Cil.OpCodes]::Ret))
}
    
