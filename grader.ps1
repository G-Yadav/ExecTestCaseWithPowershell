$fileC = $args[0];
$file = $fileC.Split(".");
# Write-Host "file name is "
$fileName = $file[0]
$fileExt = $file[1]

g++ $fileC
if($?) {
    # .\a.exe > output.txt 
    # ./a.exe | Out-File -FilePath ./output.txt
    Start-Process -FilePath "a.exe" -RedirectStandardInput "./temp/input.txt" -RedirectStandardOutput "./temp/my_output.txt" -RedirectStandardError "./temp/error.txt" 
    if($LASTEXITCODE -eq 0)
    {
        # Compare-object (get-content ./temp/my_output.txt) (get-content ./temp/output.txt)
        Start-Sleep -s 1
        if(Compare-object -ReferenceObject $(get-content "./temp/my_output.txt") -DifferenceObject $(get-content "./temp/output.txt"))
            {"files are different"}
        Else 
            {"Files are the same"}
        Write-Host "`nThe last PS command executed successfully"
    } 
    else 
    {
        Write-Host "The last PS command failed"
    }
}