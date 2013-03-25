<div id="main-content">
	<?php foreach($group as $key => $item){ ?>
    <div class="qlk_group">
    	<div class="title"><?php echo $item['modulename']?></div>
        <div class="clearer">&nbsp;</div>
        <?php foreach($item['module'] as $module ){ ?>
        <a href="?route=<?php echo $module['moduleid']?>"><div class="qlk_icon left"><?php echo $module['modulename']?></div></a>
        <?php } ?>
        <div class="clearer">&nbsp;</div>
    </div>
    <?php } ?>
</div>
