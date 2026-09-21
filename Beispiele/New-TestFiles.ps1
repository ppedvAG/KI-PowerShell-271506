<#
.SYNOPSIS
    Erstellt eine Testverzeichnisstruktur mit Dateien und Unterverzeichnissen.

.DESCRIPTION
    Erstellt unter dem angegebenen Pfad einen neuen Ordner. Der Ordner enthält
    Dateien direkt im Stammverzeichnis sowie weitere Unterverzeichnisse mit
    jeweils der angegebenen Anzahl an Dateien.

    Existiert der Zielordner bereits, wird er ohne -Force nicht verändert.

.PARAMETER Path
    Der vorhandene übergeordnete Ordner, unter dem die Teststruktur erstellt wird.

.PARAMETER FileCount
    Anzahl der Dateien im Hauptordner und in jedem Unterordner.
    Zulässige Werte liegen zwischen 1 und 99. Standardwert ist 9.

.PARAMETER DirCount
    Anzahl der zu erstellenden Unterordner.
    Zulässige Werte liegen zwischen 0 und 99. Standardwert ist 2.

.PARAMETER Name
    Name des zu erstellenden Hauptordners.
    Der Name muss zwischen 5 und 20 Zeichen lang sein. Standardwert ist
    "TestFiles2".

.PARAMETER Force
    Entfernt einen bereits vorhandenen Zielordner einschließlich seines Inhalts,
    bevor die neue Teststruktur erstellt wird.

.EXAMPLE
    .\New-TestFiles -Path C:\Temp

    Erstellt C:\Temp\TestFiles2 mit 9 Dateien und 2 Unterordnern.

.EXAMPLE
    .\New-TestFiles -Path C:\Temp -Name TestData -FileCount 3 -DirCount 4 -Force

    Erstellt die Teststruktur C:\Temp\TestData neu. Jeder Ordner enthält
    3 Dateien; vorhandene Inhalte werden vorher entfernt.

.INPUTS
    Keine. Parameter werden über die Kommandozeile übergeben.

.OUTPUTS
    Microsoft.PowerShell.Commands.Internal.FormatEntryData
    Die von New-Item erzeugten Objekte können in der PowerShell ausgegeben werden.

.NOTES
    Der Inhalt der erzeugten Dateien ist leer.

.LINK
    https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_comment_based_help
#>
param(
[Parameter(Mandatory=$true)]
[ValidateScript({Test-Path -Path $PSItem -PathType Container})]
[string]$Path,

[ValidateRange(1,99)]
[int]$FileCount = 9,

[ValidateRange(0,99)]
[int]$DirCount = 2,

[ValidateLength(5,20)]
[string]$Name = "TestFiles2",

[switch]$Force
)

# Join-Path setzt den übergeordneten Pfad und den Namen plattformgerecht zusammen.
[string]$TestFilesDirPath = Join-Path -Path $Path -ChildPath $Name

# Wenn der Zielordner existiert, wird er nur mit -Force ersetzt.
if(Test-Path -Path $TestFilesDirPath -PathType Container)
{
    if($Force)
    {
        # -Recurse löscht auch alle Dateien und Unterordner im Zielordner.
        Remove-Item -Path $TestFilesDirPath -Recurse -Force
    }
    else
    {
        # Ohne -Force werden vorhandene Testdaten nicht versehentlich überschrieben.
        Write-Host -Object "Ordner vorhanden"
        exit
    }
}

# New-Item gibt ein Objekt zurück. Über .FullName kann später der vollständige
# Pfad des neu erstellten Ordners verwendet werden.
$TestFilesDir = New-Item -Path $Path -Name $Name -ItemType Directory

# Erstellt Dateien direkt im Hauptordner.
for($i = 1; $i -le $FileCount; $i++)
{
    # D2 formatiert die laufende Nummer zweistellig, zum Beispiel File01.txt.
    $Filename = "File" + ("{0:D2}" -f $i) + ".txt"
    New-Item -Path $TestFilesDir.FullName -Name $Filename -ItemType File
}

# Erstellt die gewünschte Anzahl an Unterordnern.
for($i = 1; $i -le $Dircount; $i++)
{
    # Auch die Unterordner erhalten zweistellige Nummern, zum Beispiel Dir01.
    $Dirname = "Dir" + ("{0:D2}" -f $i) 
    $subdir = New-Item -Path $TestFilesDir.FullName -Name $Dirname -ItemType Directory

    # Für jeden Unterordner wird eine eigene Dateischleife gestartet.
    for($j = 1; $j -le $FileCount; $j++)
    {
        # Der Name enthält den Namen des Unterordners, zum Beispiel Dir01-File01.txt.
        $FileName = $Dirname + "-File" + ("{0:D2}" -f $j) + ".txt"
        New-Item -Path $subdir.FullName -Name $Filename -ItemType File
    }
}