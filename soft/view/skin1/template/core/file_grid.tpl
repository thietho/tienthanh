

<div class="clearer">^&nbsp;</div>
<div id="listfilecontent">
<?php if(count($folderchild)){ ?>
	<?php foreach($folderchild as $folder){ ?>
    <div class="left folderlist folderitem filelist" filepath="<?php echo $folder['folderpath']?>" folderpath="<?php echo $folder['foldername']?>" title="<?php echo $folder['foldername']?>" filename="<?php echo $folder['foldername']?>" style="background:url('<?php echo DIR_IMAGE?>folder.png')  no-repeat center center">
    	<table>
        	
        	<tr>
            	<td><?php echo $folder['foldername']?></td>
            </tr>
        </table>
    	
    </div>
    <?php }?>





<?php } ?>
<?php 
	if(count($files))
   		foreach($files as $file){ ?>
	<div class="left">
        <div class="filelist fileitem text-center" id="<?php echo $file['fileid']?>" imagethumbnail="<?php echo $file['imagethumbnail']?>" filename="<?php echo $file['filename']?>" filepath="<?php echo $file['filepath']?>" style="background:url('<?php echo $file['imagethumbnail']?>') no-repeat center center" title="<?php echo $file['filename']?>">
            
            <p class="filename"><?php echo substr($file['filename'],0,20)?></p>
                
            
            
        </div>
        
    </div>
<?php } ?>

	<div class="clearer">^&nbsp;</div>
</div>

<script language="javascript">
$(function(){
    $.contextMenu({
        selector: '.filelist', 
        callback: function(key, options) {
            var m = "clicked: " + key;
            window.console && console.log(m);
			
			switch(key)
			{
				case "edit":
					file.show($(this).attr('filepath'));
					break;
				case "delete":
					$(this).addClass('selectfile');
					file.del();
					break;
				case "copy":
					$('#listfilecontent').contextMenu(true);
					
					$(this).addClass('selectfile');
					$('.selectfile').each(function(index, element) {
						if(file.clipboard.indexOf($(this).attr('filepath'))==-1)
                        	file.clipboard.push($(this).attr('filepath'));
                    });
					
					console.log("clipboard: "+ file.clipboard);
					break;
				case "cut":
					$('#listfilecontent').contextMenu(true);
					
					$(this).addClass('selectfile');
					$('.selectfile').each(function(index, element) {
						if(file.clipboard.indexOf($(this).attr('filepath'))==-1)
                        	file.clipboard.push($(this).attr('filepath'));
                    });
					file.iscut = true;
					console.log("clipboard: "+ file.clipboard);
					break;
				case "newfolder":
					file.newFolder();
					break;
				case "rename":
					file.rename($(this));
					break;
				
			}
        },
        items: {
			
          	"edit": {name: "Edit", icon: "edit"},
			"cut": {name: "Cut", icon: "cut"},
			"copy": {name: "Copy", icon: "copy"},
			"newfolder": {name: "New Folder", icon: "folder"},
			"rename": {name: "Rename", icon: "rename"},
			"delete": {name: "Delete", icon: "delete"},
        }
    });
});
$(function(){
    $.contextMenu({
        selector: '#listfilecontent', 
        callback: function(key, options) {
            var m = "clicked: " + key;
            window.console && console.log(m);
			
			switch(key)
			{
				case "paste":
					file.copy();
					break;
				
				
				
			}
        },
        items: {
			
          	
			"paste": {name: "Paste", icon: "paste"},
			
        }
    });
});
$(document).ready(function(e) {
    
	if(file.clipboard.length > 0)
	{
		$('#listfilecontent').contextMenu(true);
		console.log("clipboard: "+ file.clipboard);
	}
	else
		$('#listfilecontent').contextMenu(false);
});
</script>