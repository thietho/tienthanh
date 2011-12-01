<div class="section">

<div class="section-title"><?php echo $heading_title?></div>

<div class="section-content">

<form action="" method="post" id="listorder" name="listorder">

<div class="button right"><input class="button" type="button"
	name="delete_all" value="<?php echo $button_cancel?>"
	onclick="deleteorder()" /></div>
<div class="clearer">&nbsp;</div>

<div class="sitemap treeindex">
<table class="data-table" cellpadding="0" cellspacing="0">
	<tbody>
		<tr class="tr-head">
			<th width="1%"><input class="inputchk" type="checkbox"
				onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>

			<th width="25%"><?php echo $column_customername?></th>
			<th width="35%"><?php echo $column_address?></th>
			<th width="15%"><?php echo $column_phone?></th>
			<th width="15%"><?php echo $column_orderdate?></th>
			<th width="10%">&nbsp;</th>
		</tr>


		<?php
		foreach($orders as $order)
		{
			?>
		<tr>
			<td class="check-column"><input class="inputchk" type="checkbox"
				name="delete[<?php echo $order['orderid']?>]"
				value="<?php echo $order['orderid']?>"></td>

			<td><a
				href="?route=addon/order/view&orderid=<?php echo $order['orderid']?>"><?php echo $order['customername']?></a></td>
			<td><?php echo $order['address']?></td>
			<td><?php echo $order['email']?></td>
			<td><?php echo $this->date->formatMySQLDate($order['orderdate'])?> <?php echo $this->date->getTime($order['orderdate'])?></td>
			<td class="link-control"><a class="button"
				onclick="activeorder('<?php echo $order['orderid']?>')"><?php echo $order['text_active']?></a>
			</td>
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
