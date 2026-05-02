Get-Process WINWORD -EA SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 1

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc  = $word.Documents.Add()
$sel  = $word.Selection

function RGB2Word($hex) {
    $r = [Convert]::ToInt32($hex.Substring(0,2),16)
    $g = [Convert]::ToInt32($hex.Substring(2,2),16)
    $b = [Convert]::ToInt32($hex.Substring(4,2),16)
    return $b * 65536 + $g * 256 + $r
}
$ROUGE = RGB2Word 'C0392B'
$OR    = RGB2Word 'D4A017'
$NOIR  = RGB2Word '1A1A1A'
$VERT  = RGB2Word '27AE60'
$GRIS  = RGB2Word 'F0F0F0'
$BLEU  = RGB2Word '2980B9'
$BLANC = 16777215
$CREME = RGB2Word 'FDF6EC'
$GREY2 = RGB2Word '888888'
$DARK  = RGB2Word '1A1A1A'
$MED   = RGB2Word '555555'
$LIGHT = RGB2Word 'AAAAAA'

$doc.PageSetup.TopMargin    = $word.CentimetersToPoints(2.5)
$doc.PageSetup.BottomMargin = $word.CentimetersToPoints(2.5)
$doc.PageSetup.LeftMargin   = $word.CentimetersToPoints(2)
$doc.PageSetup.RightMargin  = $word.CentimetersToPoints(2)

# En-tete
$hdr = $doc.Sections(1).Headers(1)
$hr  = $hdr.Range
$hr.Font.Name  = 'Arial'
$hr.Font.Size  = 11
$hr.Font.Bold  = 1
$hr.Font.Color = $BLANC
$hr.Paragraphs(1).Shading.BackgroundPatternColor = $NOIR
$hr.Paragraphs(1).Alignment = 1
$hr.Paragraphs(1).Borders.Item(3).LineStyle = 1
$hr.Paragraphs(1).Borders.Item(3).Color     = $ROUGE
$hr.Paragraphs(1).Borders.Item(3).LineWidth = 8
$hr.Text = "CASTELLANE AUTO-ECOLE  -  Espace Candidat - Compte Rendu Mot de Passe"

# Pied de page
$ftr = $doc.Sections(1).Footers(1)
$ftr.Range.Font.Name  = 'Arial'
$ftr.Range.Font.Size  = 9
$ftr.Range.Font.Color = $GREY2
$ftr.Range.Paragraphs(1).Alignment = 1
$ftr.Range.Paragraphs(1).Borders.Item(1).LineStyle = 1
$ftr.Range.Paragraphs(1).Borders.Item(1).Color     = $ROUGE
$ftr.Range.Text = "Document genere le 13/04/2026 - Projet Castellane Auto-Ecole"
$ftr.PageNumbers.Add(1) | Out-Null

# Titre
$sel.Paragraphs.Last.Shading.BackgroundPatternColor = $NOIR
$sel.Paragraphs.Last.Alignment = 1
$sel.Paragraphs.Last.Format.SpaceBefore = 10
$sel.TypeText('COMPTE RENDU')
$sel.Paragraphs.Last.Range.Font.Name  = 'Arial'
$sel.Paragraphs.Last.Range.Font.Size  = 28
$sel.Paragraphs.Last.Range.Font.Bold  = 1
$sel.Paragraphs.Last.Range.Font.Color = $BLANC
$sel.TypeParagraph()

$sel.TypeText('Creation de Mot de Passe - Espace Candidat')
$sel.Paragraphs.Last.Range.Font.Name  = 'Arial'
$sel.Paragraphs.Last.Range.Font.Size  = 16
$sel.Paragraphs.Last.Range.Font.Bold  = 1
$sel.Paragraphs.Last.Range.Font.Color = $OR
$sel.Paragraphs.Last.Shading.BackgroundPatternColor = $NOIR
$sel.Paragraphs.Last.Alignment = 1
$sel.TypeParagraph()

$sel.TypeText('Auto-Ecole Castellane - Toulon  -  13 avril 2026')
$sel.Paragraphs.Last.Range.Font.Name  = 'Arial'
$sel.Paragraphs.Last.Range.Font.Size  = 10
$sel.Paragraphs.Last.Range.Font.Bold  = 0
$sel.Paragraphs.Last.Range.Font.Color = $LIGHT
$sel.Paragraphs.Last.Shading.BackgroundPatternColor = $NOIR
$sel.Paragraphs.Last.Alignment = 1
$sel.Paragraphs.Last.Format.SpaceAfter = 18
$sel.TypeParagraph()

function SecTitle($text) {
    $sel.TypeText($text)
    $sel.Paragraphs.Last.Range.Font.Name  = 'Arial'
    $sel.Paragraphs.Last.Range.Font.Size  = 13
    $sel.Paragraphs.Last.Range.Font.Bold  = 1
    $sel.Paragraphs.Last.Range.Font.Color = $BLANC
    $sel.Paragraphs.Last.Shading.BackgroundPatternColor = $ROUGE
    $sel.Paragraphs.Last.LeftIndent = $word.CentimetersToPoints(0.4)
    $sel.Paragraphs.Last.Format.SpaceBefore = 14
    $sel.Paragraphs.Last.Format.SpaceAfter  = 6
    $sel.TypeParagraph()
}

function NLine($text, $bold, $color, $indent) {
    $sel.TypeText($text)
    $sel.Paragraphs.Last.Range.Font.Name  = 'Arial'
    $sel.Paragraphs.Last.Range.Font.Size  = 11
    $sel.Paragraphs.Last.Range.Font.Bold  = [int]$bold
    $sel.Paragraphs.Last.Range.Font.Color = $color
    $sel.Paragraphs.Last.LeftIndent = $word.CentimetersToPoints($indent)
    $sel.Paragraphs.Last.Shading.BackgroundPatternColor = $BLANC
    $sel.Paragraphs.Last.Format.SpaceAfter = 4
    $sel.TypeParagraph()
}

function BLine($text, $color) {
    $sel.TypeText([char]0x2022 + '  ' + $text)
    $sel.Paragraphs.Last.Range.Font.Name  = 'Arial'
    $sel.Paragraphs.Last.Range.Font.Size  = 11
    $sel.Paragraphs.Last.Range.Font.Color = $color
    $sel.Paragraphs.Last.LeftIndent = $word.CentimetersToPoints(1)
    $sel.Paragraphs.Last.Shading.BackgroundPatternColor = $BLANC
    $sel.Paragraphs.Last.Format.SpaceAfter = 3
    $sel.TypeParagraph()
}

# SECTION 1
SecTitle '  SECTION 1 - INFORMATIONS GENERALES'
NLine 'Date               : 13 avril 2026'                               $false $DARK 0.5
NLine 'Projet             : Castellane Auto-Ecole - Application Web PHP'  $false $DARK 0.5
NLine 'Module concerne    : Espace Candidat (Espace Eleve)'               $false $DARK 0.5
NLine 'Pages concernees   : front/login.php  et  front/inscription.php'   $false $DARK 0.5
$sel.TypeParagraph()

# SECTION 2
SecTitle '  SECTION 2 - MOT DE PASSE GENERE'

$sel.TypeText('Ce4@Ar7#')
$sel.Paragraphs.Last.Range.Font.Name  = 'Courier New'
$sel.Paragraphs.Last.Range.Font.Size  = 36
$sel.Paragraphs.Last.Range.Font.Bold  = 1
$sel.Paragraphs.Last.Range.Font.Color = $ROUGE
$sel.Paragraphs.Last.Shading.BackgroundPatternColor = $CREME
$sel.Paragraphs.Last.Alignment = 1
$sel.Paragraphs.Last.Borders.Item(1).LineStyle = 1
$sel.Paragraphs.Last.Borders.Item(1).Color     = $OR
$sel.Paragraphs.Last.Borders.Item(1).LineWidth = 6
$sel.Paragraphs.Last.Borders.Item(3).LineStyle = 1
$sel.Paragraphs.Last.Borders.Item(3).Color     = $OR
$sel.Paragraphs.Last.Borders.Item(3).LineWidth = 6
$sel.Paragraphs.Last.Borders.Item(4).LineStyle = 1
$sel.Paragraphs.Last.Borders.Item(4).Color     = $ROUGE
$sel.Paragraphs.Last.Borders.Item(4).LineWidth = 18
$sel.Paragraphs.Last.Format.SpaceBefore = 10
$sel.Paragraphs.Last.Format.SpaceAfter  = 2
$sel.TypeParagraph()

$sel.TypeText('8 caracteres  -  2 Majuscules  -  2 Minuscules  -  2 Chiffres  -  2 Speciaux')
$sel.Paragraphs.Last.Range.Font.Name  = 'Arial'
$sel.Paragraphs.Last.Range.Font.Size  = 9
$sel.Paragraphs.Last.Range.Font.Bold  = 0
$sel.Paragraphs.Last.Range.Font.Color = $GREY2
$sel.Paragraphs.Last.Shading.BackgroundPatternColor = $CREME
$sel.Paragraphs.Last.Alignment = 1
$sel.Paragraphs.Last.Format.SpaceAfter = 10
$sel.TypeParagraph()

NLine 'Detail de la composition :' $true $DARK 0

$tbl = $doc.Tables.Add($sel.Range, 9, 3)
$tbl.Style = 'Table Grid'
foreach ($c in 1..3) {
    $tbl.Cell(1,$c).Shading.BackgroundPatternColor = $ROUGE
    $tbl.Cell(1,$c).Range.Font.Color = $BLANC
    $tbl.Cell(1,$c).Range.Font.Bold  = 1
    $tbl.Cell(1,$c).Range.Font.Name  = 'Arial'
    $tbl.Cell(1,$c).Range.Font.Size  = 10
}
$tbl.Cell(1,1).Range.Text = 'Caractere'
$tbl.Cell(1,2).Range.Text = 'Type'
$tbl.Cell(1,3).Range.Text = 'Position'

$data = @(
    @('C','Majuscule','1'),
    @('e','Minuscule','2'),
    @('4','Chiffre','3'),
    @('@','Caractere special','4'),
    @('A','Majuscule','5'),
    @('r','Minuscule','6'),
    @('7','Chiffre','7'),
    @('#','Caractere special','8')
)
for ($i = 0; $i -lt $data.Count; $i++) {
    $row = $i + 2
    for ($c = 1; $c -le 3; $c++) {
        $tbl.Cell($row,$c).Range.Font.Name = 'Arial'
        $tbl.Cell($row,$c).Range.Font.Size = 10
        $tbl.Cell($row,$c).Range.Text      = $data[$i][$c-1]
    }
    if ($i % 2 -eq 0) {
        foreach ($c in 1..3) {
            $tbl.Cell($row,$c).Shading.BackgroundPatternColor = $GRIS
        }
    }
}
$tbl.Columns(1).Width = $word.CentimetersToPoints(3)
$tbl.Columns(2).Width = $word.CentimetersToPoints(8)
$tbl.Columns(3).Width = $word.CentimetersToPoints(3)

$sel.EndOf(6) | Out-Null
$sel.TypeParagraph()

NLine 'Recapitulatif de conformite :' $true $DARK 0
BLine '2 Majuscules : C, A'                    $VERT
BLine '2 Minuscules : e, r'                    $VERT
BLine '2 Chiffres : 4, 7'                      $VERT
BLine '2 Caracteres speciaux : @, #'           $VERT
BLine 'Longueur : 8 caracteres (max respecte)' $VERT
$sel.TypeParagraph()

# SECTION 3
SecTitle "  SECTION 3 - CONTEXTE D'UTILISATION"
NLine "L'espace candidat est accessible via front/login.php. Le candidat se connecte avec son email comme identifiant." $false $DARK 0.5
$sel.TypeParagraph()
NLine 'Formulaire de connexion :' $true $DARK 0

$tbl2 = $doc.Tables.Add($sel.Range, 3, 2)
$tbl2.Style = 'Table Grid'
foreach ($c in 1..2) {
    $tbl2.Cell(1,$c).Shading.BackgroundPatternColor = $BLEU
    $tbl2.Cell(1,$c).Range.Font.Color = $BLANC
    $tbl2.Cell(1,$c).Range.Font.Bold  = 1
    $tbl2.Cell(1,$c).Range.Font.Name  = 'Arial'
    $tbl2.Cell(1,$c).Range.Font.Size  = 10
}
$tbl2.Cell(1,1).Range.Text = 'Champ'
$tbl2.Cell(1,2).Range.Text = 'Valeur'
$tbl2.Cell(2,1).Range.Text = 'Identifiant (email)'
$tbl2.Cell(2,2).Range.Text = 'exemple@email.com'
$tbl2.Cell(3,1).Range.Text = 'Mot de passe'
$tbl2.Cell(3,2).Range.Text = 'Ce4@Ar7#'
$tbl2.Cell(3,2).Range.Font.Bold  = 1
$tbl2.Cell(3,2).Range.Font.Color = $ROUGE
foreach ($r in 2..3) {
    foreach ($c in 1..2) {
        $tbl2.Cell($r,$c).Range.Font.Name = 'Arial'
        $tbl2.Cell($r,$c).Range.Font.Size = 10
    }
}
$tbl2.Columns(1).Width = $word.CentimetersToPoints(5)
$tbl2.Columns(2).Width = $word.CentimetersToPoints(9)

$sel.EndOf(6) | Out-Null
$sel.TypeParagraph()

NLine 'Apres connexion, le candidat accede a mon_espace.php :' $true $DARK 0
BLine 'Ses lecons planifiees'  $DARK
BLine 'Ses factures'           $DARK
BLine 'Son suivi de formation' $DARK
$sel.TypeParagraph()

# SECTION 4
SecTitle "  SECTION 4 - PROCEDURE D'INSCRIPTION"
NLine 'Champs du formulaire front/inscription.php :' $false $DARK 0.3
$items = @(
    'Nom *',
    'Prenom *',
    'Adresse email * (identifiant de connexion)',
    'Telephone',
    'Date de naissance',
    'Adresse postale',
    'Mot de passe * (minimum 6 car. -- Ce4@Ar7# est conforme avec 8 car.)',
    'Confirmation du mot de passe *'
)
for ($i = 0; $i -lt $items.Count; $i++) {
    $sel.TypeText(($i+1).ToString() + '.  ' + $items[$i])
    $sel.Paragraphs.Last.Range.Font.Name  = 'Arial'
    $sel.Paragraphs.Last.Range.Font.Size  = 11
    $sel.Paragraphs.Last.Range.Font.Color = $DARK
    $sel.Paragraphs.Last.LeftIndent = $word.CentimetersToPoints(1)
    $sel.Paragraphs.Last.Format.SpaceAfter = 3
    $sel.TypeParagraph()
}
$sel.TypeParagraph()
NLine 'Stockage : password_hash() PHP -- algorithme bcrypt (PASSWORD_DEFAULT)' $false $MED 0.5
$sel.TypeParagraph()

# SECTION 5
SecTitle '  SECTION 5 - SECURITE'
BLine 'Algorithme de hachage : PASSWORD_DEFAULT (bcrypt)'                 $DARK
BLine 'Verification login : password_verify() PHP'                        $DARK
BLine 'Mot de passe Ce4@Ar7# satisfait les exigences minimales (6 car.)'  $DARK
BLine 'Aucun stockage en clair en base de donnees'                        $DARK
BLine 'Complexite : majuscules + minuscules + chiffres + caracteres speciaux' $DARK

# Sauvegarde
$path = 'C:\wamp64\www\Castellane_AutoEcole\projet_autoecole\front\Compte_Rendu_MotDePasse_EspaceCandidat.docx'
$doc.SaveAs2($path, 16)
$doc.Close()
$word.Quit()

Write-Host "DONE: $path"
