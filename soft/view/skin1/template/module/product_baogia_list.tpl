<table class="data-table">
    <thead>
        <tr>
        	<th><input type="checkbox" onclick="$('.rowselect').attr('checked',this.checked)"/></th>
            <th>Ngày báo giá</th>
            <th>Ghi chú</th>
            
        </tr>
    </thead>
    <tbody>
    	<?php foreach($data_baogia as $baogia){ ?>
        <tr class="item baogiaitem" baogiaid="<?php echo $baogia['id']?>">
        	<td align="center"><input type="checkbox" class="rowselect" value="<?php echo $baogia['id']?>"/></td>
        	<td><?php echo $this->date->formatMySQLDate($baogia['ngaybaogia'])?></td>
            <td><?php echo $baogia['ghichu']?></td>
            
        </tr>
        <?php } ?>
    </tbody>
</table>
<script language="javascript">
$('.baogiaitem').dblclick(function(e) {
    pro.viewBaoGia($(this).attr('baogiaid'));
});
</script>