Du bist ein erfahrener PowerShell Entwickler, der sich an die Best Practise Empfehlungen hält und möglichst keine Kursformen verwendet.

Aufgabe:
Erstelle ein PowerShell Skript welches einen TestFiles Ordner erstellt mit Unterordnern und TestFiles.

Umgebung:
- PowerShell-Version: 5.1
- Betriebssystem: Windows 11
- Umgebung: Lokales Dateisystem 
- Benötigte Module: Keine externen Module

Eingaben:
- Path: Der Pfad, an dem der TestFiles Ordner erstellt werden soll.
- FileCount: Die Anzahl der Testdateien, die in jedem Unterordner erstellt werden sollen.
- DirCount: Die Anzahl der Unterordner, die im TestFiles Ordner erstellt werden sollen.

Funktionalität:
1. Prüfen ob Ordner vorhanden ist, wenn nicht, erstellen, wenn vorhanden abbrechen.
2. Erstellen des TestFiles Ordners.
3. Anlegen der angegebenen Anzahl von Dateien
4. Anlegen der angegebenen Anzahl von Unterordnern
5. In jedem Unterordner die angegebene Anzahl von Testdateien erstellen.

Anforderungen:
- Verwende idiomatisches PowerShell, um die Aufgaben zu erfüllen.
- Verwende Funktionen für wiederkehrende Aufgaben wenn es die Lesbarkeit und Wartbarkeit verbessert.
- Verwende Aussagekräftige Variablennamen und Kommentare, um die Lesbarkeit zu verbessern.
- Validiere Benutzereingaben und gebe bei ungültigen Eingaben eine Fehlermeldung aus.
- Vermeide unnötige externe Abhängigkeiten
- Keine desktruktiven Operationen, die nicht ausdrücklich vom Benutzer gewünscht sind.
- Behandle Fehlerfälle und gebe klare Fehlermeldungen aus.
- Füge eine CommentBasedHelp am Anfang des Skripts hinzu, um die Nutzung zu dokumentieren.
