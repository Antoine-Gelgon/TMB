<?php
$text=$_GET['log'];
$xml = simplexml_load_file('xml/'.$text.'.xml');
$titre = $xml->meta->titre;
$description = $xml->meta->description;
$tags = $xml->meta->tags;
$count = $xml->meta->notecount;
?>
<header>
    <span> <b>TITRE:</b> <?php echo $titre; ?></span>
    <span> <b>DESCRIPTION:</b> <?php echo $description; ?></span>
    <span> <b>TAGS:</b> <?php echo $tags; ?></span>
    <span> <b>POSTES:</b> <?php echo $count; ?></span>
</header>

<?php

foreach($xml->notes->note as $pas){
    $contenu=$pas->contenu;
    $image=$pas->image;
    $id=$pas->id;
    $datepost=$pas->creationdate;
    $enter = array('[c]','[/c]','[l]','[/l]');
    $exit = array('<code>','</code>','<a>','</a>');
    $contenu = str_replace($enter, $exit, $contenu);
    $contenu = preg_replace('#http://[a-z0-9._/-]+#i', '<a TARGET="_BLANK" href="$0">$0</a>', $contenu);
    $contenu = preg_replace('#https://[a-z0-9._/-]+#i', '<a TARGET="_BLANK" href="$0">$0</a>', $contenu);
    echo '<div class="note" id="'.$id.'" >';
    echo '<div class="date">'.$datepost.'</div><br>';
    echo $contenu.'<br>';
    if(!empty($image)){
	echo '<img src="images/'.$image.'" />';
    }
    echo '</div>';
    }
?>

<script>
$('.note').click(function(){
   $('.colZoomInt').empty(); 
    var text = $(this).html();
   $('.colZoomInt').append(text); 
 });
</script>
