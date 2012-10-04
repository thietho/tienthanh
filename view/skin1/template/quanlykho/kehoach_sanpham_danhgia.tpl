<table>
	<thead>
    	<tr>
            <th>Mã SP</th>
            <th>Tên SP</th>
            <th>SL qui định SX 1 lot</th>
            <th>Tổng số cái SX</th>
            <th>Qui đổi số LOT SX</th>
            <th>Thành tiền</th>
            <th>Kết quả thực hiện</th>
            <th>Kết quả kinh doanh</th>
            
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
            	<?php echo $this->string->numberFormate($item['sosanphamtrenlot'])?>
                <input type="hidden" id="sosanphamtrenlot-<?php echo $key?>" name="sosanphamtrenlot[<?php echo $key?>]" value="<?php echo $item['sosanphamtrenlot']?>"/>
            </td>
            <td>
            	<?php echo $this->string->numberFormate($item['soluong'])?>
                
            </td>
            <td class="number"><?php echo $this->string->numberFormate($item['solot'])?></td>
            <td id="thanhtienview-<?php echo $key?>" class="number"><?php echo $this->string->numberFormate($item['thanhtien'])?></td>
            <td><textarea id="ketquathuchien-<?php echo $key?>" name="ketquathuchien[<?php echo $key?>]"><?php echo $item['ketquathuchien']?></textarea> </td>
            <td><textarea id="ketquakinhdoanh-<?php echo $key?>" name="ketquakinhdoanh[<?php echo $key?>]"><?php echo $item['ketquakinhdoanh']?></textarea> </td>
            
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