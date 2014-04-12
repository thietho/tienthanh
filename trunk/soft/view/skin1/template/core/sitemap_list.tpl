<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $menu_sitemap ?></div>
    
    <div class="section-content">
    
    	<form action="" id="formlist" name="formlist" method="post">
        
        	<div class="button right">
                <input class="button" value="<?php echo $button_add ?>" type="button" onclick="linkto('<?php echo $insert?>')">
                <input class="button" value="<?php echo $button_delete ?>" name="btnDel" type="button" onclick="deleteList()">
                <input class="button" value="<?php echo $button_update ?>" name="btnUpdate" type="button" onclick="updateList()">
                <input type="hidden" name="type" value="" />
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div class="sitemap treeindex">

                <link href="<?php echo DIR_VIEW?>css/jquery.treeTable.css" rel="stylesheet" type="text/css" />
                  <script type="text/javascript" src="<?php echo DIR_VIEW?>js/jquery.treeTable.js"></script>
                  <script type="text/javascript">
                  $(document).ready(function() {
                    // TODO Fix issue with multiple treeTables on one page, each with different options
                    // Moving the #example3 treeeTable call down will break other treeTables that are expandable...
                    $(".example").treeTable();
                  });
                  
                  </script>
                <table class="example data-table" width="100%">
                    <thead>
                    <tr class="tr-head">
                     <th align="left" width="30%">
        <?php
            if($this->session->data['userid']=='admin')
            {
        ?>
                     <input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
        <?php
            }
        ?>             
                     &nbsp;Menu</th>
                      <th width="25%"><?php echo $text_editmodule?></th>
                      <th width="10%"><?php echo $text_status?></th>
        <?php
            if($this->session->data['userid']=='admin')
            {
        ?>
                      <th width="300px"><?php echo $text_control?></th>
        <?php
            }
        ?>
                    </tr>
                    </thead>
                    
                    <tbody>
        <?php
            foreach($sitemaps as $sitemap)
            {
        ?>
                    <tr id="<?php echo $sitemap['eid']?>" class="<?php echo $sitemap['class']?>">
                      
                      <td><?php echo $sitemap['tab']?>
                 <?php
                if($this->session->data['userid']=='admin')
                {
        ?>
                        <input class="inputchk" type="checkbox" name="delete[<?php echo $sitemap['sitemapid']?>]" value="<?php echo $sitemap['sitemapid']?>" >
        <?php
                }
        ?>
                        <input class="text" maxlength="2" size="1" type="text" name="position[<?php echo $sitemap['sitemapid']?>]" value="<?php echo $sitemap['position']?>">&nbsp;&nbsp;<?php echo $sitemap['sitemapname']?>
                      </td>
                      <td><?php echo $sitemap['modulename']?></td>
                      <td><?php echo $sitemap['status']?></td>
        <?php
                if($this->session->data['userid']=='admin')
                {
        ?>
                      <td>
                            <a href="<?php echo $insert?>&parent=<?php echo $sitemap['sitemapid']?>" class="button" title="[Add child]"><?php echo $button_addchild ?></a> 
                            <a href="<?php echo $sitemap['update']?>" class="button" title="[Edit]"><?php echo $button_edit?></a> 
                            
                      </td>
        <?php
                }
        ?>
                    </tr>
        <?php
            }
             
        ?>
                    </tbody>
                    
                </table>
             
            </div>
        
        </form>
    
    </div>

</div>
<script language="javascript">
function updateList()
{
	$.post("?route=core/sitemap/updateposition", 
			$("#formlist").serialize(), 
			function(data)
			{
				if(data!="")
				{
					alert(data);
					window.location.reload();
				}
			}
	);
}
function deleteList()
{
	$.post("?route=core/sitemap/delete", 
			$("#formlist").serialize(), 
			function(data)
			{
				if(data!="")
				{
					alert(data);
					window.location.reload();
				}
			}
	);
}
</script>