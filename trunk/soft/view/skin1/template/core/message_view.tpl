<div class="section">

	<div class="section-title">
    	<?php echo $breadcrumb?>
    </div>
    
    <div class="section-content padding1">
    
    	<form name="InsertContent"  action="" method="post" enctype="multipart/form-data">
    
    	<div class="left">
            
            <h3><?php echo $heading_title?>Message</h3>
        
        </div>
        
    	<div class="right">
            <a class="button" href="<?php echo $reply?>"/>Reply</a>
            <a class="button" href="#" onclick="javascript:history.go(-1)"/>Cancel</a>
        </div>
        <div class="clearer">&nbsp;</div>
        
        
        <div id="container">
        	
            
        	<ul>
                <li><a href="#fragment-1"><span>Message</span></a></li>
            </ul>
           
            
            <div id="fragment-1">
            	
                <div style="<?php echo $displaynews?>">
        			
                    <div>
                        <p>
                            <label>From:</label><br>
                            <?php echo $from?>
                        </p>
                        <p>
                            <label>To:</label><br>
                            <?php echo $to?>
                        </p>
                        <p>
                            <label>Subject:</label><br>
                            <?php echo $title?>
                        </p>
                    </div>
                    
                    <div>
                        
                        <div id="errorupload" class="error" style="display:none"></div>
                        
                        <div class="loadingimage" style="display:none"></div>
                        <p>
                        	<a id="btnAddAttachment"></a><br />
                        </p>
                        <p id="attachment">
                        </p>
                    	
                        <span id="delfile"></span>
                    </div>

                    <div class="clearer">&nbsp;</div>
                
                </div>

<script language="javascript">
	
	$(document).ready(function() {
   	// put all your jQuery goodness in here.
<?php
		if(count($listfileid)>0)
		{
			
			foreach($listfileid as $item)
			{
				if(count($item))
				{
?>
			$('#attachment').append(creatAttachmentRowView('<?php echo $item['fileid']?>','<?php echo $item['filename']?>','<?php echo DIR_FILE.$item['filepath']?>','<?php echo $item['imagethumbnail']?>'));
<?php
				}
			}
		}
?>
 	});

</script>
                <div>
                    <p>
                        <?php echo html_entity_decode($description)?>
                    </p>  
                </div>
                
            </div>
        </div>
        
        </form>
    
    </div>

</div>

<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>
<script src="<?php echo DIR_JS?>jquery.tabs.pack.js" type="text/javascript"></script>

<script type="text/javascript" charset="utf-8">
var DIR_UPLOADATTACHMENT = "<?php echo $DIR_UPLOADATTACHMENT?>";
</script>

<script src="<?php echo DIR_JS?>uploadattament.js" type="text/javascript"></script>