
<div class="grid_15">
<div class="suffix_1"><?php
$media=$medias[0];
?>
<h2><?php echo $media['title']?></h2>
<div class="wrapper"><?php if($media['imagethumbnail'] !=""){ ?> <a
	href='<?php echo $media["link"]?>'><img
	src='<?php echo $media['imagethumbnail']?>' alt="" class="img-indent" /></a>
<?php }?>

<p><?php echo $media['summary']?></p>

<a href="<?php echo $media['link']?>" class="link1">Read More</a></div>
<div class="separator"></div>
<?php
$media=$medias[1];
?>
<h2><?php echo $media['title']?></h2>
<?php if($media['imagethumbnail'] !=""){ ?> <a
	href='<?php echo $media["link"]?>'
	onClick="control.loadContent(this.href)"><img
	src='<?php echo $media['imagethumbnail']?>' alt="" class="img-indent" /></a>
<?php }?>

<p><?php echo $media['summary']?></p>
<a href="<?php echo $media['link']?>"
	onClick="control.loadContent(this.href)" class="link1">Read More</a></div>
</div>
