# backupFiles.psm1

function backUpFiles {
    param (
        $sourcePath,
        $destinationPath,
        $Mir = 'yes',
        $Opts = $null
        # 變數名稱說明：sourcePath 來源路徑；destinationPath 目標路徑；Mir 是否使用完整複製，yes 為是、no 為否；Opts 額外的 robocopy 參數，例如要排除名稱為 My Music 的資料夾就是 /xd `"My Music`"
        # Mir: 相當於 /E /PURGE，/E 是複製來源所有的目錄，也包含空目錄；/PURGE 表示刪除目標資料夾（目錄），不存在於來源資料夾（目錄）的項目，簡單來說就是建立一個來源目錄的鏡像備份。
    )

    write-host "`n正在開始備份" -nonewline
    # write-host " $sourcePath " -ForegroundColor 'DarkCyan' -BackgroundColor 'Gray' -nonewline
    write-host " $sourcePath " -ForegroundColor 'Magenta' -nonewline
    write-host "的檔案...`n"

    # 是否使用鏡像備份（使用完整複製，而不使用增量複製）
    if ( $Mir -eq 'yes' -or $Mir -eq 'no') {
        if ( $Mir -eq 'yes') {
            # 是否有要使用額外的 robocopy 參數
            if ( $null -eq $Opts ) {
                robocopy $sourcePath $destinationPath /mir /ndl
            }
            else {
                $command = "robocopy `"$sourcePath`" `"$destinationPath`" /mir /ndl $Opts"
                invoke-expression $command
            }
        }
        else {
            if ( $null -eq $Opts ) {
                robocopy $sourcePath $destinationPath /e /ndl
            }
            else {
                $command = "robocopy `"$sourcePath`" `"$destinationPath`" /e /ndl $Opts"
                invoke-expression $command
            }
        }

        # 目前還沒有備份失敗的警告訊息。
        # (實作中

        # error catch 機制的參考
        # powershell - How to really understand robocopy return code of 2 - Stack Overflow
        # https://stackoverflow.com/questions/41844717/how-to-really-understand-robocopy-return-code-of-2/41849020#41849020

        # 在 Azure Pipelines 裡面正確使用 ROBOCOPY 複製檔案的方法 | The Will Will Web
        # https://blog.miniasp.com/post/2021/07/23/Properly-Use-Robocopy-Exit-Codes-in-Azure-Pipelines?fbclid=IwAR0sGXiLKc9c_DLKjTen6MbvdGoYxXNnCXuNweVIT2FhZtvuKzCYmpSd2xE

        # Robocopy Exit Codes - Windows CMD - SS64.com
        # https://ss64.com/nt/robocopy-exit.html
        
        # robocopy | Microsoft Docs
        # https://docs.microsoft.com/zh-tw/windows-server/administration/windows-commands/robocopy#exit-return-codes

        if ( $LastExitCode -eq 0 ) {
            write-host "`nExitCode $LastExitCode：沒有發生錯誤，也沒有備份任何檔案，一天又平安地過去了（來源與目標的內容相同）" -ForegroundColor 'Cyan' -nonewline
            write-host "`n`n"
        }
        elseif ( $LastExitCode -eq 1 ) {
            write-host "`nExitCode $LastExitCode：成功備份" -ForegroundColor 'Cyan' -nonewline
            write-host " $sourcePath " -ForegroundColor 'White' -nonewline
            write-host "的檔案`n`n" -ForegroundColor 'Cyan'
        }

        elseif ( $LastExitCode -eq 2 ) {
            # write-host "`nExitCode $LastExitCode：沒有任何檔案被複製，發現了額外的檔案或目錄" -ForegroundColor 'DarkRed' -BackgroundColor 'Yellow' -nonewline
            write-host "`nExitCode $LastExitCode：警告  沒有任何檔案被複製，發現了額外的檔案或目錄" -ForegroundColor 'DarkYellow' -nonewline
            write-host "`n`n"
        }

        # ExitCode 2+1
        elseif ( $LastExitCode -eq 3 ) {
            write-host "`nExitCode $LastExitCode：注意  " -ForegroundColor 'Yellow' -nonewline
            write-host "檔案成功複製，發現了額外的檔案或目錄" -ForegroundColor 'Green' -nonewline
            write-host "`n`n"
        }

        elseif ( $LastExitCode -eq 4 ) {
            write-host "`nExitCode $LastExitCode：警告  發現了未匹配的檔案或目錄" -ForegroundColor 'DarkYellow' -nonewline
            write-host "`n`n"
        }

        # ExitCode 4+1
        elseif ( $LastExitCode -eq 5 ) {
            write-host "`nExitCode $LastExitCode：注意  " -ForegroundColor 'Yellow' -nonewline
            write-host "檔案成功複製，發現了不匹配的檔案或目錄" -ForegroundColor 'Green' -nonewline
            write-host "`n`n"
        }

        # ExitCode 4+2
        elseif ( $LastExitCode -eq 6 ) {
            write-host "`nExitCode $LastExitCode：警告  沒有任何檔案被複製，發現了額外與未匹配的檔案或目錄" -ForegroundColor 'DarkYellow' -nonewline
            write-host "`n`n"
        }

        # ExitCode 4+1+2
        elseif ( $LastExitCode -eq 7 ) {
            write-host "`nExitCode $LastExitCode：注意  " -ForegroundColor 'Yellow' -nonewline
            write-host "檔案成功複製，發現了額外與未匹配的檔案或目錄" -ForegroundColor 'Green' -nonewline
            write-host "`n`n"
        }

        elseif ( $LastExitCode -eq 8 ) {
            write-host "`nExitCode $LastExitCode：>>> 錯誤  多個檔案或目錄無法複製，需要檢查執行紀錄 <<<" -ForegroundColor 'DarkRed' -nonewline
            write-host "`n`n"
        }

        elseif ( $LastExitCode -eq 16 ) {
            write-host "`nExitCode $LastExitCode：>>> 嚴重的錯誤  Robocopy 沒有任何檔案被複製，可能缺少必要的權限，或來源及目標目錄不存在， <<<" -ForegroundColor 'DarkRed' -nonewline
            write-host "`n`n"
        }

        else {
            # write-host "`nExitCode $LastExitCode：糟了，是世界奇觀。你召喚出千年難得一遇的 bug 了。" -ForegroundColor 'DarkRed' -BackgroundColor 'Yellow' -nonewline
            write-host "`nExitCode $LastExitCode：糟了，是世界奇觀。你召喚出千年難得一遇的 bug 了。" -ForegroundColor 'DarkRed' -nonewline
            write-host "`n`n"
        }
        
        # write-host [bool]($LastExitCode -eq 16)
    }
    else {
        # write-host "`nExitCode $LastExitCode：預料外的輸入，請確認後再試一次: $Mir " -ForegroundColor 'DarkRed' -BackgroundColor 'Yellow' -nonewline
        write-host "`nExitCode $LastExitCode：預料外的輸入，請確認後再試一次: $Mir " -ForegroundColor 'Yellow' -nonewline
        write-host "`n`n"
    }

}
