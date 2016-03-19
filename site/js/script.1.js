$(document).ready(function(){
    if(window.location.anchor!=""){
	$(".col").load(window.location.anchor+".html body");
    }

 $.ajaxSetup({cache:false});
     $("a").click(function(){
	var post_link = $(this).attr("data-log");
	//alert(post_link);
	$(".colInt").html('loading');
	$(".colInt").load('single.php?log='+post_link);
	return false;
     });


   
});
