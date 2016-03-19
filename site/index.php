<html>
<head lang="fr-FR">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <script type="text/javascript" src="js/jquery-1.12.1.min.js"></script>
</head>
    <body>
    <div class="col-droit">	
<?php
	$dir = 'xml/';
if (is_dir($dir)) {
    if ($dh = opendir($dir)) {
        while (($file = readdir($dh)) !== false) {
          if( $file != '.' && $file != '..' && preg_match('#\.(xml)$#i', $file)) {
	    $file = explode(".", $file);    
	    $xml_list = simplexml_load_file('xml/'.$file[0].'.xml');
	    $titre = $xml_list->meta->titre;
	    $tag_list = $xml_list->meta->tags;
	    //$tag_list = explode(',',$tag_list);	    
?>
	       <a data-log="<?php echo $file[0];?>" href="#<?php echo $file[0]; ?>">
		    <?php echo $titre; ?>
		</a><br> <br>
        <?php
	    }
        }
        closedir($dh);
    }
}
?></div>
    <div class="contenu">
	<div class="col">
	    <div class="colInt"></div>
	</div>
	<div class="colZoom">
	    <div class="colZoomInt"></div>
	</div>
    </div>
    <script type="text/javascript" src="js/script.1.js"></script>
    </body>
<html>
