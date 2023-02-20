
import-module "C:\Users\kos\Desktop\Program\windows 10 scripts\modules\backupFiles.psm1"

# for test
# mir = 完全複製(會刪除檔案) 預設為 yes
# e = 增加複製(只會新增檔案)
# xd 排除指定資料夾
# xf 排除指定檔案
# ndl 不顯示複製紀錄
# copy 指定檔案要複製的內容 (預設值為 DAT (資料、屬性和時間戳記))
# dcopy 指定目錄要複製的內容 (預設值為 DA (資料和屬性))

if (-not (test-path E:)) {
    write-host "`nE:\未連接!`n"
    exit
}

# 文件
backUpFiles -sourcePath "C:\Users\kos\Documents" -destinationPath "E:\Data\文件" -Opts "/xd `"My*`" /xd `"Visual Studio 2019`" /xd `"自訂 Office 範本`" /xd `"Blackmagic Design`" /xd `"Telegram Desktop`" /xd `"Rockstar Games`" /dcopy:D"

# programing - scripts
backUpFiles -sourcePath "C:\Users\kos\Desktop\Program\scripts" -destinationPath "E:\Programing\scripts"

# Downloaders - TwitterImageDLer (增量複製)
backUpFiles -sourcePath "C:\Users\kos\Pictures\TwitterImageDLer" -destinationPath "E:\Data\圖片\Downloader\TwitterImageDLer" -Mir 'no'

# backUpFiles -sourcePath  -destinationPath 
# backUpFiles -sourcePath  -destinationPath 

cmd /c 'pause'
# robocopy /?