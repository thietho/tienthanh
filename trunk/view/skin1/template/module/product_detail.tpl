<div class="ben-post">
	<?php if($post['imagethumbnail'] !=""){ ?>
	<img src='<?php echo $post['imagethumbnail']?>' class='ben-alignleft' />
    <?php }?>
    <h2><?php echo $post['title']?></h2>
    
    <div class="ben-post-body">
        <p><b><?php echo $post['summary']?></b></p>
    </div>
    <div class="clearer">&nbsp;</div>
</div>
<div class="ben-hline"></div>
<p>
    <?php echo $post['description']?>
</p>
<p class="ben-text-right">
	<b><?php echo $post['source']?></b>
</p>
<div class="ben-hline"></div>

<?php if($othernews) {?>
<h3>Các sản phẩm khác</h3>             
<div>
    <ul>
    	<?php foreach($othernews as $media) {?>
        <li><a href="<?php echo $media['link']?>" onclick="control.loadContent(this.href)"><?php echo $media['title']?>&nbsp;<span class="ben-other"></span></a></li>
        <?php } ?>    
    </ul>
</div>
<?php } ?>

<div class="clearer">&nbsp;</div>