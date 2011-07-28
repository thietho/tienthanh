<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $heading_title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
     	        <a class="button" href="index.php?route=addon/order"><?php echo $button_cancel?></a>
                
            </div>
            <div class="clearer">^&nbsp;</div>
        
        	<div>
            	<p>
            		<label><?php echo $entry_customername?></label><br />
					<?php echo $order['customername']?>
            	</p>
                <p>
            		<label><?php echo $entry_email?></label><br />
					<?php echo $order['email']?>
            	</p><p>
            		<label><?php echo $entry_address?></label><br />
					<?php echo $order['address']?>
            	</p>
                <p>
            		<label><?php echo $entry_phone?></label><br />
					<?php echo $order['phone']?>
            	</p>
                <p>
            		<label><?php echo $entry_orderdate?></label><br />
					<?php echo $this->date->formatMySQLDate($order['orderdate'])?>
            	</p>
                <p>
            		<label><?php echo $entry_status?></label><br />
					<a class="button" onclick="activeorder('<?php echo $order['orderid']?>')" ><?php echo $order['text_active']?></a>
            	</p>
                <p>
            		<label><?php echo $entry_message?></label><br />
					<?php echo $order['comment']?>
            	</p>
            </div>
            <div>
            	<table>
                	<thead>
                    	<tr>
                            <th><?php echo $column_productname?></th>
                            <th><?php echo $column_productimage?></th>
                            <th><?php echo $column_productqty?></th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php foreach($detail as $item){ ?>
                    	<tr>
                            <td><?php echo $item['title']?></td>
                            <td><?php echo $item['imagepreview']?></td>
                            <td><?php echo $item['quantity']?></td>
                        </tr>
                    <?php } ?>
                    </tbody>
                </table>
            </div>
        </form>
    
    </div>
    
</div>
<script language="javascript">
function activeorder(orderid)
{
	$.ajax({
		  url: "?route=addon/order/updatestatus&orderid="+orderid,
		  cache: false,
		  success: function(html){
			linkto("?<?php echo $_SERVER['QUERY_STRING']?>");
		  }
		});
}
</script>
