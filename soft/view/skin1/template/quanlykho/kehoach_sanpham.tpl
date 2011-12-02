<table>
	<thead>
    	<tr>
            <th>Mã SP</th>
            <th>Tên SP</th>
            
            <th>Tồn thực tại</th>
            <th>SL qui định SX 1 lot</th>
            <th>Tổng số cái SX</th>
            <th>Qui đổi số LOT SX</th>
            <th>Thành tiền</th>
            <th>Phê duyệt</th>
            <th>Phụ chú</th>
            
        </tr>
    </thead>
    <tbody>
    	<?php foreach($khsp as $key => $item){ ?>	
    	<tr>
        	<td>
            	<input type="hidden" id="id-<?php echo $key?>" name="id[<?php echo $key?>]" value="<?php echo $item['id']?>"/>
            	<?php echo $this->document->getSanPham($item['masanpham'])?>
            	<input type="hidden" id="masanpham-<?php echo $key?>" name="masanpham[<?php echo $key?>]" value="<?php echo $item['masanpham']?>"/>
            </td>
            <td>
            	<?php echo $item['tensanpham']?>
                <input type="hidden" id="tensanpham-<?php echo $key?>" name="tensanpham[<?php echo $key?>]" value="<?php echo $item['tensanpham']?>"/>
            </td>
            
            <td class="number">
            	<?php echo $this->string->numberFormate($item['soluongtonhientai'])?>
                <input type="hidden" id="soluongtonhientai-<?php echo $key?>" name="soluongtonhientai[<?php echo $key?>]" value="<?php echo $item['soluongtonhientai']?>"/>
            </td>
            <td class="number">
            	<?php echo $this->string->numberFormate($item['sosanphamtrenlot'])?>
                <input type="hidden" id="sosanphamtrenlot-<?php echo $key?>" name="sosanphamtrenlot[<?php echo $key?>]" value="<?php echo $item['sosanphamtrenlot']?>"/>
            </td>
            <td>
            	<input type="text" class="text number soluong" id="soluong-<?php echo $key?>" name="soluong[<?php echo $key?>]" value="<?php echo $item['soluong']?>" />
                <input type="hidden" id="dongia-<?php echo $key?>" name="dongia[<?php echo $key?>]" value="<?php echo $item['dongia']?>"/>
            </td>
            <td class="number"><input type="text" class="text number solot" id="solot-<?php echo $key?>" name="solot[<?php echo $key?>]" value="<?php echo $item['solot']?>" /></td>
            <td id="thanhtienview-<?php echo $key?>" class="number"><?php echo $this->string->numberFormate($item['thanhtien'])?></td>
            <td><input type="checkbox" id="pheduyet-<?php echo $key?>" name="pheduyet[<?php echo $key?>]" value="1" <?php if($item['pheduyet']==1) echo 'checked="checked"';?> /></td>
            <td><textarea id="phuchu-<?php echo $key?>" name="phuchu[<?php echo $key?>]"><?php echo $item['phuchu']?></textarea> </td>
            
        </tr>
        <?php } ?>
    </tbody>
</table>
<script language="javascript">
$('.soluong').keyup(function(e) {
    var arr = this.id.split('-');
	var currow = arr[1];
	var thanhtien = stringtoNumber(this.value) * $('#dongia-'+currow).val();
	var solot = stringtoNumber(this.value) / $('#sosanphamtrenlot-'+currow).val();
	$('#thanhtienview-'+currow).html(numberView(thanhtien));
	$('#solot-'+currow).val(numberView(solot))
});

$('.solot').keyup(function(e) {
    var arr = this.id.split('-');
	var currow = arr[1];
	var soluong = stringtoNumber(this.value) * $('#sosanphamtrenlot-'+currow).val();
	var thanhtien = soluong * $('#dongia-'+currow).val();
	$('#thanhtienview-'+currow).html(numberView(thanhtien));
	$('#soluong-'+currow).val(numberView(soluong))
});

</script>