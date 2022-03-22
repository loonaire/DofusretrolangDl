
Ce script permet de télécharger les fichiers lang de dofus retro, par défaut il télécharger sur le par défaut et récupère les fichiers de la langue française.
L'avantage de ce script est qu'il peux être utilisé sur n'importe quel ordinateur Windows sans avoir besoin de télécharger un logiciel supplémentaire, il est préférable d'utiliser powershell 7 si possible mais il marche avec powershell 5.  
Pour pouvoir l'exécuter, il faut activer l'utilisation des scripts powershell avec la commande:

```powershell
Set-ExecutionPolicy Unrestricted
```

Pour afficher l'aide:

```powershell
Get-Help langdl.ps1 
```

Pour télécharger avec un lien personnalisé et/ou une autre langue:

```powershell
./langdl.ps1 -Url <Url personnalisé> -Language <Langue souhaitée>
```

Ce script est largement perfectible et fait rapidement mais il marche.  