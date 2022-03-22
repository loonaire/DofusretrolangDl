<#
.DESCRIPTION
Télécharge les fichiers lang de dofus rétro.
Langue des fichiers à télécharger, français par défaut.
Les possibilités sont: de, en, es, fr, it, nl, pt 

.SYNOPSIS
Télécharge les lang de dofus rétro

.PARAMETER Url
URL où sont situé les lang (par défaut ceux de dofus original)

.PARAMETER Language
Langue des fichiers à télécharger, français par défaut.
Les possibilités sont: de, en, es, fr, it, nl, pt 
#>


# TODO prévoir le cas ou on veux télécharger plusieurs langues?

param([string] $Url, [string] $Language)

# si l'url n'est pas précisée, on prend celle par défauts
if ( -not $Url ) {
    $Url = "http://dofusretro.cdn.ankama.com/"
}
# on se place dans le dossier qui contient le fichier de version
$downloadUrl = $Url + "lang/"

# si le language n'est pas indiqué en paramètre, on met le français par défaut
if ( -not $Language) {
    $Language = "fr"
}

# Crée le dossier de destination
$destDir = "lang_" + $Language + "_" + $(Get-Date).ToString("dd_MM_yyyy-HH_mm")
New-Item -Path . -ItemType Directory -Name $destDir | Out-Null
New-Item -Path ./$destDir -ItemType Directory -Name swf | Out-Null

# Prépare les informations pour récupérer le fichier versions txt puis télécharge le fichier versions.txt
$versionFile = "versions_" + $Language + ".txt"
$dlVersionFile = $downloadUrl + $versionFile

$destVersionFiles = $destDir + "/"+ $versionFile

Invoke-WebRequest -Uri $dlVersionFile -OutFile $destVersionFiles | Out-Null

# Parse le fichier versions txt pour récupérer les noms de fichier à télécharger 

$Content = Get-Content $destVersionFiles

# retire le &f= au début du fichier, le $Content.Length -4 correspond à la taille de la chaine à partir du 4ième 
# caractère et retire à la fin le | en trop, permet d'éviter d'avoir un caractère en plus à la fin
$Content = $Content.Substring(3,$Content.Length - 4)

# Split la chaine de caractère en tableau de chaine pour récupérer chaque fichier
$Content = $Content.Split("|")

# Ensuite, pour chaque élément de la chaine de caractère, on re split pour obtenir cette fois: nom, langue, version
foreach ( $item in $Content ) {
    # Pour chaque élément, on le split et télécharger le fichier associé
    $item = $item.Split(",")
	
	# on obtient un fichier avec le nom: nom_langue_version.swf
    $filename = $item[0] + "_" + $item[1] + "_" + $item[2] + ".swf"

    # On télécharge le fichier
	Write-Host "Téléchargement du fichier $filename en cours..." -ForegroundColor Green

    $downloadFileUrl = $downloadUrl + "swf/" + $filename
    $outDownloadFile = $destDir + "/swf/" + $filename

    Invoke-WebRequest -Uri $downloadFileUrl -OutFile $outDownloadFile | Out-Null
	
	Write-Host "Fichier $filename Téléchargé!" -ForegroundColor Green
}


