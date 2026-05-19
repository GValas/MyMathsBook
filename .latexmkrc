# Configuration latexmk pour MyMathsBook
#
# Chaîne de compilation complète : pdflatex → makeindex → makeglossaries → bibtex → pdflatex ×2
#   $pdf_mode = 1       : produit un PDF via pdflatex
#   $pdflatex           : options de compilation (-synctex pour SyncTeX, -nonstopmode pour ne pas
#                         bloquer sur les erreurs, -file-line-error pour des messages lisibles)
#   $out_dir            : tous les fichiers intermédiaires (.aux, .log, .toc…) vont dans build/
#   $makeindex          : commande pour générer l'index (fichier .idx → .ind)
#   add_cus_dep         : déclare des dépendances personnalisées pour le glossaire :
#                           .glo → .gls  (entrées de glossaire principal)
#                           .acn → .acr  (entrées d'acronymes)
#   run_makeglossaries  : sous-routine appelée par latexmk pour lancer makeglossaries
#                         en ciblant le bon répertoire de sortie (build/)

$pdf_mode = 1;
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$out_dir = 'build';
$makeindex = 'makeindex %O -o %D %S';

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
    use File::Basename;
    my ($base_name, $path) = fileparse($_[0]);
    return system("makeglossaries -d \"$path\" $base_name");
}
